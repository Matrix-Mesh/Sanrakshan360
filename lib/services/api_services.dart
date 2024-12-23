import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:s360/constants/api_consts.dart';

class ApiServices {
  static Future<void> getModels() async{
    try{
      var response = await http.get(Uri.parse("$BASE_URL/models"),
      headers: {
        'Authorization': 'Bearer $API_KEY'
      },);

      Map jsonResponse = jsonDecode(response.body);
      print("jsonResponse $jsonResponse");

    } catch(err){
      print("error $err");
    }
  }
}