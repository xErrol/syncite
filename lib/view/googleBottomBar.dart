import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'homePage.dart';

class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({Key? key}) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text('Generate QR Page')),
    Center(child: Text('Event Nemsu Map Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Image(
      image: AssetImage('assets/images/qr.png'),
      width: 30,
      height: 30,
    ),
    title: const Text("Generate QR"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Image(
      image: AssetImage('assets/images/maps.png'),
      width: 24,
      height: 24,
    ),
    title: const Text("Nemsu Event Maps"),
    selectedColor: Colors.blue,
  ),
  SalomonBottomBarItem(
    icon: const Image(
      image: AssetImage('assets/images/profile.png'),
      width: 24,
      height: 24,
    ),
    title: const Text("Profile"),
    selectedColor: Colors.blue,
  ),
];
