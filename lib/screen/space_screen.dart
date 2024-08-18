import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'full_image_show.dart';

class SpaceScreen extends StatefulWidget {
  const SpaceScreen({super.key});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  List<String> imagesUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImagesUrls();
  }

  Future<void> fetchImagesUrls() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult result = await storage.ref('space/').listAll();
    final List<String> urls = [];

    for (var ref in result.items) {
      final String downloadURL = await ref.getDownloadURL();
      urls.add(downloadURL);
    }
    setState(() {
      imagesUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Wallpaper"),
      ),
      body: GestureDetector(
        child: imagesUrls.isEmpty
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
                    builder: (context) => FullImageShow(
                      imageUrls: imagesUrls,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imagesUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
