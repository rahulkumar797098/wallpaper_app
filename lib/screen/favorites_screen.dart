import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<List<String>> _fetchFavoriteImages() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('userFavorites')
          .get();

      return snapshot.docs.map((doc) => doc['url'] as String).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: FutureBuilder<List<String>>(
        future: _fetchFavoriteImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites yet.'));
          }

          final favoriteImages = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteImages.length,
            itemBuilder: (context, index) {
              final imageUrl = favoriteImages[index];
              return ListTile(
                leading: Image.network(imageUrl),
                title: Text('Favorite ${index + 1}'),
              );
            },
          );
        },
      ),
    );
  }
}
