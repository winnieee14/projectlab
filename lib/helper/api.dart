import 'dart:convert';

import 'package:projectlab/models/product.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

const baseURL = 'http://10.0.2.2:3000';

Future<User?> tryLogin(String username, String password) async {
  String url = '$baseURL/users/login';

  var response = await http.post(Uri.parse(url), body: {
    'username': username,
    'password': password,
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return User.fromJson(data['user']);
  }
  return null;
}

Future<bool> register(String username, String password) async {
  String url = '$baseURL/users/register';

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('$baseURL/api/products'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    print('Failed to load products: ${response.statusCode}');
    return [];
  }
}

Future<bool> addProduct({
  required String title,
  required double price,
  required String description,
  required String genre,
  required String level,
  required String imageUrl,
}) async {
  final response = await http.post(
    Uri.parse('$baseURL/api/products'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": title,
      "price": price,
      "description": description,
      "genre": genre,
      "level": level,
      "imageUrl": imageUrl,
    }),
  );

  return response.statusCode == 200;
}

Future<void> deleteProduct(int id) async {
  final url = Uri.parse('$baseURL/api/products/$id');
  final response = await http.delete(url);

  if (response.statusCode != 200) {
    throw Exception('Gagal menghapus produk');
  }
}
