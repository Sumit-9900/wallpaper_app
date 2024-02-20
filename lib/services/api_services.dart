import 'dart:convert';

import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/utils/const.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<WallpaperModel> getApi() async {
    try {
      final url = Uri.parse(baseurlCurated);
      final res = await http.get(
        url,
        headers: {
          "Authorization": apikey,
        },
      );
      Map<String, dynamic> data = jsonDecode(res.body);
      return WallpaperModel.fromJson(data);
    } catch (e) {
      throw Exception('Exception Occured :- $e');
    }
  }
  Future<WallpaperModel> getApi1() async {
    try {
      final url = Uri.parse(baseurlSearch);
      final res = await http.get(
        url,
        headers: {
          "Authorization": apikey,
        },
      );
      Map<String, dynamic> data = jsonDecode(res.body);
      return WallpaperModel.fromJson(data);
    } catch (e) {
      throw Exception('Exception Occured :- $e');
    }
  }
}
