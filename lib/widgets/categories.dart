import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/screens/category.dart';
import 'package:wallpaper_app/services/api_services.dart';
import 'package:wallpaper_app/services/utils/const.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<WallpaperModel>? fetchingg;

  @override
  void initState() {
    super.initState();
    fetchingg = ApiServices().getApi1();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Nature',
      'Cars',
      'MotorCycle',
      'Meditation',
      'Headphones',
      'Technology',
      'House',
      'Temples',
    ];
    List<String> cateUrl = [
      'https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg',
      'https://images.pexels.com/photos/120049/pexels-photo-120049.jpeg?auto=compress&cs=tinysrgb&h=350',
      'https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg',
      'https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&h=130',
      'https://images.pexels.com/photos/1037992/pexels-photo-1037992.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
      'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&h=130',
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
      'https://images.pexels.com/photos/1583244/pexels-photo-1583244.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 8.0,
            right: 6.0,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                baseurlSearch =
                    'https://api.pexels.com/v1/search?query=${categories[index]}&per_page=80';
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Categoryy(
                    category: categories[index],
                    catUrl: cateUrl[index],
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                SizedBox(
                  height: 50,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      cateUrl[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black38,
                  ),
                ),
                Positioned(
                  left: 6,
                  bottom: 12,
                  child: Text(
                    categories[index],
                    style: const TextStyle(
                      color: Color.fromARGB(155, 255, 255, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
