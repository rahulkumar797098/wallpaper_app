import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/categorie_screen.dart';
import 'package:wallpaper_app/screen/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentScreen = 0;
  final List<Widget> screens = [
    const CategorieScreen(),
    const FavoritesScreen()
  ];

  void _onTapScreen(int index) {
    setState(() {
      currentScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: myNavigation(context),
    );
  }

  Widget myNavigation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(0, "Categories", "assets/images/cat_blank.png", "assets/images/cat_fill.png"),
          buildNavItem(1, "Favorites", "assets/images/heart.png", "assets/images/heart (1).png"),
        ],
      ),
    );
  }

  Widget buildNavItem(
      int index,
      String label,
      String iconPathUnselected,
      String iconPathSelected,
      ) {
    bool isSelected = currentScreen == index;

    return GestureDetector(
      onTap: () => _onTapScreen(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isSelected ? iconPathSelected : iconPathUnselected,
            width: 30,
            height: 30,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
