import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/animal_image_screen.dart';
import 'package:wallpaper_app/screen/car_image_screen.dart';
import 'package:wallpaper_app/screen/nature_image_screen.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              size: 30,
            ),
            Icon(
              Icons.account_circle,
              size: 30,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: catData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 3.5,
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 11),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // Check if the selected category is "Cars & Vehicles"
              if (catData[index]["title"] == "Cars & Vehicles") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CarImageScreen()),
                );
              } else if(catData[index]["title"] == "Nature"){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const NatureImageScreen()));
              }
              else if(catData[index]["title"] == "Animals"){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const AnimalImageScreen()));
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
                          top: Radius.circular(15)),
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
    );
  }
}
