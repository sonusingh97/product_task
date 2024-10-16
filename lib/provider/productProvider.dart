// providers/product_provider.dart
import 'package:flutter/material.dart';

import '../Services/apiServices.dart';
import '../model/productModel.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _originalProducts = [];
  List<ProductModel> get products => _products;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  ApiService _apiService = ApiService();

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _products = await _apiService.fetchProducts();
      _originalProducts = List.from(_products);
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void sortByPrice(bool isLowToHigh) {
    if (isLowToHigh) {
      _products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      _products.sort((a, b) => b.price.compareTo(a.price));
    }
    notifyListeners();
  }
  void clearSorting() {
    _products = List.from(_originalProducts); // Reset to original product list
    notifyListeners(); // Notify the UI to rebuild
  }
}
