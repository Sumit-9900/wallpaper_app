import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/search_screen.dart';
import 'package:wallpaper_app/services/utils/const.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  TextEditingController controller = TextEditingController();
  String enterredtext = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void search() {
    if (enterredtext.trim().isNotEmpty) {
      setState(() {
        baseurlSearch =
            'https://api.pexels.com/v1/search?query=$enterredtext&per_page=80';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            maxHeight: 60,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        onChanged: (value) {
          enterredtext = value;
        },
        onSubmitted: (_) {
          search();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchScreen(text: enterredtext),
            ),
          );
          controller.clear();
        },
      ),
    );
  }
}
