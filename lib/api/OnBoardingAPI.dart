import 'dart:async';
import 'dart:convert';
import 'package:haimal/models/OnBoarding.dart';
import 'package:haimal/server.dart';
import 'package:http/http.dart' as http;

Future<List<OnBoarding>> fetchScreens() async {
  final response = await http.get(Uri.parse('$server/api/constants/screens/'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => OnBoarding.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
