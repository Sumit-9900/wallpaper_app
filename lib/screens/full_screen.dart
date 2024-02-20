import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({
    super.key,
    required this.imageurl,
  });

  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              imageurl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 125,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(99, 0, 0, 0),
                foregroundColor: const Color.fromARGB(202, 255, 255, 255),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                try {
                  int location = WallpaperManager.BOTH_SCREEN;
                  File file =
                      await DefaultCacheManager().getSingleFile(imageurl);
                  await WallpaperManager.setWallpaperFromFile(
                    file.path,
                    location,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wallpaper has been set!!!'),
                      ),
                    );
                  }
                } catch (e) {
                  throw Exception('Exception Occurred :- $e');
                }
              },
              child: const Text('SET WALLPAPER'),
            ),
          ),
          Positioned(
            top: 20,
            left: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
