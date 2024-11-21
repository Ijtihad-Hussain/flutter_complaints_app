import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String apiUrl = 'https://brownonions-002-site2.ftempurl.com/api/ChefRegister/ValidateChefPassword';

  Future<bool> authenticate(String password) async {
    final String url = '$apiUrl?ChefId=3&CurrentPassword=$password&APIKey=mobileapi19042024';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status']==1) {
        return true;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}