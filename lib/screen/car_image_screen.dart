import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'full_image_show.dart'; // Import your FullImageShow class

class CarImageScreen extends StatefulWidget {
  const CarImageScreen({super.key});

  @override
  State<CarImageScreen> createState() => _CarImageScreenState();
}

class _CarImageScreenState extends State<CarImageScreen> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    FirebaseStorage storage = FirebaseStorage.instance;
        final ListResult result = await storage.ref('car/').listAll();

    // Iterate over each item in the folder
    final List<String> urls = [];
    for (var ref in result.items) {
      final String downloadURL = await ref.getDownloadURL();
      urls.add(downloadURL);
    }
    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Images'),
      ),
      body: imageUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullImageShow(imageUrls: imageUrls , initialIndex: index,),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imageUrls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
