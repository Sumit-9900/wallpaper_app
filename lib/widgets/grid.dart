import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/full_screen.dart';
import 'package:wallpaper_app/services/api_services.dart';

class Grid extends StatefulWidget {
  const Grid({super.key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  Future<WallpaperModel>? fetchdata;

  @override
  void initState() {
    super.initState();
    fetchdata = ApiServices().getApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WallpaperModel>(
      future: fetchdata,
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
              return InkWell(
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
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(42, 0, 0, 0),
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
    );
  }
}
