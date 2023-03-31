import 'dart:developer';

import 'package:food_app/Models/UserModel.dart';

import '../const/api_const.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>?> getUsers() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}user');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> _usersList = userFromJson(response.body);
        return _usersList;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
