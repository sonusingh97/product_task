import 'dart:convert';

import '../constant/apiUrl.dart';
import '../model/productModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiConstant.productApi));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
