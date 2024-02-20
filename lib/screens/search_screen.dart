import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/full_screen.dart';
import 'package:wallpaper_app/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<WallpaperModel>? fetched;

  @override
  void initState() {
    super.initState();
    fetched = ApiServices().getApi1();
  }

  String get textt {
    return widget.text[0].toUpperCase() + widget.text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textt),
        centerTitle: true,
      ),
      body: Expanded(
        child: FutureBuilder<WallpaperModel>(
          future: fetched,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data!.photos!;
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 4,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FullScreen(
                            imageurl: data[index].src!.portrait!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(42, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          data[index].src!.portrait!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error fetching data'),
              );
            }
          },
        ),
      ),
    );
  }
}
