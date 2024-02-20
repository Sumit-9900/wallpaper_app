import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/full_screen.dart';
import 'package:wallpaper_app/services/api_services.dart';

class Categoryy extends StatefulWidget {
  const Categoryy({
    super.key,
    required this.category,
    required this.catUrl,
  });

  final String category;
  final String catUrl;

  @override
  State<Categoryy> createState() => _CategoryyState();
}

class _CategoryyState extends State<Categoryy> {
  Future<WallpaperModel>? fetching;

  @override
  void initState() {
    super.initState();
    fetching = ApiServices().getApi1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              widget.catUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<WallpaperModel>(
              future: fetching,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
        ],
      ),
    );
  }
}
