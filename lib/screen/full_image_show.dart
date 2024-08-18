import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FullImageShow extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullImageShow({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  _FullImageShowState createState() => _FullImageShowState();
}

class _FullImageShowState extends State<FullImageShow> {
  bool isFavorited = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final currentImageUrl =
      widget.imageUrls[_pageController.page?.toInt() ?? widget.initialIndex];
      final snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('userFavorites')
          .doc(currentImageUrl)
          .get();

      setState(() {
        isFavorited = snapshot.exists;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final currentImageUrl =
      widget.imageUrls[_pageController.page?.toInt() ?? widget.initialIndex];
      final favoritesRef = FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('userFavorites');

      if (isFavorited) {
        await favoritesRef.doc(currentImageUrl).delete();
        await FirebaseStorage.instance
            .ref(
            'favourite_screen/${Uri.parse(currentImageUrl).pathSegments.last}')
            .delete(); // Delete the image from storage
      } else {
        final storageRef = FirebaseStorage.instance.ref(
            'favourite_screen/${Uri.parse(currentImageUrl).pathSegments.last}');
        try {
          await storageRef.putFile(await _downloadImageToFile(currentImageUrl));
          await favoritesRef.doc(currentImageUrl).set({'url': currentImageUrl});
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add image to favorites: $e')),
          );
        }
      }

      setState(() {
        isFavorited = !isFavorited;
      });
    }
  }

  Future<File> _downloadImageToFile(String url) async {
    var dio = Dio();
    var dir = await getTemporaryDirectory();
    String savePath = '${dir.path}/temp_image.jpg';
    await dio.download(url, savePath);
    return File(savePath);
  }

  Future<void> downloadImage(BuildContext context) async {
    if (await Permission.storage.isGranted) {
      _startDownload(context);
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        _startDownload(context);
      } else if (status.isDenied || status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Storage permission is required to download images.')),
        );
        if (status.isPermanentlyDenied) {
          openAppSettings(); // Opens settings directly
        }
      }
    }
  }

  void _startDownload(BuildContext context) async {
    try {
      var dio = Dio();
      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        String savePath = '${dir.path}/downloaded_image.jpg';
        await dio.download(
            widget.imageUrls[_pageController.page?.toInt() ?? widget.initialIndex],
            savePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image downloaded to $savePath')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              _checkIfFavorited(); // Check if the new image is favorited
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            left: 10,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent.shade100.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      downloadImage(context);
                    },
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black87,
                            blurRadius: 4,
                            offset: Offset(2.0, 2.0))
                      ],
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Share functionality can be added here
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black87,
                            blurRadius: 4,
                            offset: Offset(2.0, 2.0))
                      ],
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      color: isFavorited ? Colors.red : Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black87,
                            blurRadius: 4,
                            offset: Offset(2.0, 2.0))
                      ],
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Info functionality can be added here
                    },
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black87,
                            blurRadius: 4,
                            offset: Offset(2.0, 2.0))
                      ],
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
