// custom_bottom_bar.dart
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  // You might want to use a state management solution to handle this index
  // (like Provider, GetX, Bloc, etc.) if you need to access it from other parts of your app
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white, // Match this to your scaffold background
      color: Theme.of(context).primaryColor, // Use your app's primary color
      buttonBackgroundColor: Theme.of(context).primaryColor,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      index: _currentIndex,
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.search, size: 30, color: Colors.white),
        Icon(Icons.add, size: 30, color: Colors.white),
        Icon(Icons.favorite, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        
        // Here you'll need to add navigation logic based on the index
        // For example:
        switch (index) {
          case 0:
            // Navigate to Home screen
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case 1:
            // Navigate to Search screen
            Navigator.of(context).pushReplacementNamed('/search');
            break;
          // Add cases for other navigation items
          default:
            break;
        }
      },
    );
  }
}