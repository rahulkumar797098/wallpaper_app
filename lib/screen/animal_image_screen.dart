import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'full_image_show.dart';

class AnimalImageScreen extends StatefulWidget {
  const AnimalImageScreen({super.key});



  @override
  State<AnimalImageScreen> createState() => _AnimalImageScreenState();
}

class _AnimalImageScreenState extends State<AnimalImageScreen> {

  List<String> animalImage = [] ;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();

  }

  Future<void> fetchImageUrls() async{

    FirebaseStorage storage = FirebaseStorage.instance ;
    final ListResult animalImageList = await storage.ref('animal/').listAll();

    final List<String> urls = [] ;

    for(var ref in animalImageList.items) {
      final String downloadURL  = await ref.getDownloadURL();
      urls.add(downloadURL);
    }

    setState(() {
      animalImage = urls ;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Natural Images"),
        ),
        body: animalImage.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: animalImage.length,
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
                              imageUrl: animalImage[index])));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(animalImage[index]),
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
