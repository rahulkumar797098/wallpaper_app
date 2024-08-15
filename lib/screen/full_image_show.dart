import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FullImageShow extends StatelessWidget {
  final String imageUrl;

  const FullImageShow({super.key, required this.imageUrl});

  Future<void> downloadImage(BuildContext context) async {
    if (await Permission.storage.isGranted) {
      _startDownload(context);
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        _startDownload(context);
      } else if (status.isDenied || status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission is required to download images.')),
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
        await dio.download(imageUrl, savePath);
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


  void _showPermissionDeniedDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Storage permission is required to download images.')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            imageUrl,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
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
                      shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(2.0, 2.0))],
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
                      shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(2.0, 2.0))],
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Favorite functionality can be added here
                    },
                    icon: const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(2.0, 2.0))],
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
                      shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(2.0, 2.0))],
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
