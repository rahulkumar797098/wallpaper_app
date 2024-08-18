import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/full_image_show.dart';

class NatureImageScreen extends StatefulWidget {
  const NatureImageScreen({super.key});

  @override
  State<NatureImageScreen> createState() => _NatureImageScreenState();
}

class _NatureImageScreenState extends State<NatureImageScreen> {
  List<String> imageNature = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ListResult naturalImageList = await storage.ref('nature/').listAll();

    final List<String> urls = [];

    for (var ref in naturalImageList.items) {
      final String downloadURL = await ref.getDownloadURL();
      urls.add(downloadURL);
    }

    setState(() {
      imageNature = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Natural Images"),
        ),
        body: imageNature.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: imageNature.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2/3,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullImageShow(
                                    imageUrls: imageNature , initialIndex: index,)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageNature[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
