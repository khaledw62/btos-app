import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio{
  late Dio dio;
  late String userToken;
  late SharedPreferences preferences;

  Future<void> getPrefs() async {
    preferences = await SharedPreferences.getInstance();
    String? g = preferences.getString('token');
    userToken = g ??"";
  }
  CustomDio(){
    dio = Dio();
    dio.options.baseUrl = "3awn.com";
    dio.options.validateStatus = (_)=>true;
    //dio.options.headers = {'authorization':};
  }
}