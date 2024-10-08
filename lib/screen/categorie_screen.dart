import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/animal_image_screen.dart';
import 'package:wallpaper_app/screen/car_image_screen.dart';
import 'package:wallpaper_app/screen/city_screen.dart';
import 'package:wallpaper_app/screen/dark_image_screen.dart';
import 'package:wallpaper_app/screen/nature_image_screen.dart';
import 'package:wallpaper_app/screen/space_screen.dart';
import 'package:wallpaper_app/screen/technology_image_screen.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<Map<String, dynamic>> catData = [
    {"title": "Nature", "image": "assets/categorie/nature.jpeg"},
    {"title": "Animals", "image": "assets/categorie/animal.jpg"},
    {"title": "Cities & Architecture", "image": "assets/categorie/citi.jpg"},
    {"title": "Technology", "image": "assets/categorie/tech.jpg"},
    {"title": "Space", "image": "assets/categorie/space.jpg"},
    {"title": "Cars & Vehicles", "image": "assets/categorie/car.jpg"},
    {"title": "Flowers & Plants", "image": "assets/categorie/flower.jpg"},
    {"title": "Dark", "image": "assets/categorie/dark.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        title: const Text('Categories'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions:  [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/rahul.png"))
                )
              ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: catData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3.5,
            crossAxisCount: 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (catData[index]["title"] == "Cars & Vehicles") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarImageScreen(),
                  ),
                );
              } else if (catData[index]["title"] == "Nature") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NatureImageScreen(),
                  ),
                );
              } else if (catData[index]["title"] == "Animals") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnimalImageScreen(),
                  ),
                );
              } else if (catData[index]["title"] == "Space") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpaceScreen(),
                  ),
                );
              }else if (catData[index]["title"] == "Cities & Architecture") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CityScreen( ),
                  ),
                );
              }else if (catData[index]["title"] == "Dark") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DarkImageScreen( ),
                  ),
                );
              }else if (catData[index]["title"] == "Technology") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TechnologyImageScreen(),
                  ),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        catData[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      catData[index]["title"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child:  Image.asset("assets/images/icon.png"),
            ),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.workspace_premium_rounded,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "premium membership",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.file_download_rounded,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Download",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Setting",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.support,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Help",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "Exit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline_rounded,
                size: 30,
                color: Colors.orange,
              ),
              title: const Text(
                "About",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
