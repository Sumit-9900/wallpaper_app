import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/categories.dart';
import 'package:wallpaper_app/widgets/grid.dart';
import 'package:wallpaper_app/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Wallpaper',
            style: TextStyle(
              color: Color.fromARGB(163, 0, 0, 0),
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: ' Guru',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Searchbar(),
          Expanded(
            child: Categories(),
          ),
          Expanded(
            flex: 8,
            child: Grid(),
          ),
        ],
      ),
    );
  }
}
