import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "NEMSYNC",
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Make the font bold
            fontSize: 20.0, // Set the font size as needed
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Logout icon
            onPressed: () {
              // Handle logout action
              print('Logout button pressed');
              // You can add your logout logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Number of posts (for example purposes)
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Profile Info
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // Example profile image
                      radius: 20,
                    ),
                    title: const Text('Example Name'),
                    subtitle: const Text('Governor'),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Handle more actions
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Post Content
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'This is an example of a officers newsfeed post content. You can update this content with real data.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Post Actions: Like and Comment
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Like Button
                      TextButton.icon(
                        onPressed: () {
                          // Handle like button press
                        },
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.red),
                        label: const Text('10'),
                      ),
                      // Comment Input
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the FAB press
          print('Floating Action Button Pressed!');
        },
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add), // Use any icon you prefer
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Place the FAB at the bottom-right corner
    );
  }
}
