import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/full_image_show.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<String> imagesUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref('city/').listAll();
    final List<String> Urls = [];

    for (var ref in result.items) {
      final String downloadUrls = await ref.getDownloadURL();
      Urls.add(downloadUrls);
    }

    setState(() {
      imagesUrls = Urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities & Architecture"),
      ),
      body: imagesUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: imagesUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullImageShow(imageUrls: imagesUrls , initialIndex: index,)));
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(imagesUrls[index] , ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                );
              }),
    );
  }
}
