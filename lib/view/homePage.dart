import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NEMSYNC"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final content = post['content'];
              final authorId = post['authorID'];
              final likes = post['likes'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(authorId is DocumentReference ? authorId.id : authorId)
                    .get(),
                builder: (context, authorSnapshot) {
                  if (authorSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final author = authorSnapshot.data;
                  final authorName = author?['name'] ?? 'Unknown';
                  final authorRole = author?['role'] ?? 'Unknown';

                  var profileImage = author?['profileImage'];
                  if (profileImage is DocumentReference) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: profileImage.get(),
                      builder: (context, profileSnapshot) {
                        if (profileSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final profileData = profileSnapshot.data;
                        final profileImageUrl = profileData?['url'] ?? '';

                        return _buildPostCard(
                          context,
                          post.id,
                          authorName,
                          authorRole,
                          profileImageUrl.isNotEmpty
                              ? profileImageUrl
                              : 'assets/images/profile.png',
                          content,
                          likes,
                        );
                      },
                    );
                  } else if (profileImage is String &&
                      profileImage.isNotEmpty) {
                    return _buildPostCard(context, post.id, authorName,
                        authorRole, profileImage, content, likes);
                  } else {
                    return _buildPostCard(
                        context,
                        post.id,
                        authorName,
                        authorRole,
                        'assets/images/profile.png',
                        content,
                        likes);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, String postId, String authorName,
      String authorRole, String profileImageUrl, String content, int likes) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: profileImageUrl.startsWith('http')
                    ? NetworkImage(profileImageUrl)
                    : AssetImage(profileImageUrl) as ImageProvider,
              ),
              title: Text(authorName),
              subtitle: Text(authorRole),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(content, style: const TextStyle(fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                  label: Text('$likes'),
                ),
                TextButton.icon(
                  onPressed: () {
                    _showCommentDialog(context, postId);
                  },
                  icon: const Icon(Icons.comment, color: Colors.blue),
                  label: const Text('Write a comment'),
                ),
              ],
            ),
            const Divider(),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Comments').snapshots(),
              builder: (context, commentSnapshot) {
                if (commentSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = commentSnapshot.data?.docs ?? [];

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final name = comment['name'] ?? 'Anonymous';
                    final content = comment['content'] ?? '';

                    return ListTile(
                      title: Text(name),
                      subtitle: Text(content),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentDialog(BuildContext context, String postId) {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Write a Comment'),
          content: TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final comment = _commentController.text;
                if (comment.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('Comments').add({
                    'postId': postId,
                    'name': 'Anonymous', // Replace with actual user name
                    'content': comment,
                    'timestamp': Timestamp.now(),
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
