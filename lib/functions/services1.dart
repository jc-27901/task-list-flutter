import 'package:http/http.dart' as http;

import 'package:task_list/functions/users1.dart';

class Services {
  //

  static Future<List<Users>> getUsers() async {
    var url = Uri.parse('https://exceptional-studios.herokuapp.com/api/users/');
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Users> users = usersFromJson(response.body);
        return users;
      } else {
        return List<Users>();
      }
    } catch (e) {
      return List<Users>();
    }
  }
}
