import 'dart:async';
import 'dart:convert';
import 'package:haimal/models/Products.dart';
import 'package:haimal/server.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

Future<List<Products>> fetchProducts() async {
  final response = await http.get(Uri.parse('$server/api/data/products/'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Products.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
