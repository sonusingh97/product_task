import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_task/view/product/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../provider/productProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Product List'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'Low to High') {
                  Provider.of<ProductProvider>(context, listen: false)
                      .sortByPrice(true);
                } else if (result == 'High to Low') {
                  Provider.of<ProductProvider>(context, listen: false)
                      .sortByPrice(false);
                }else if (result == 'Show All Products') {
                  Provider.of<ProductProvider>(context, listen: false).clearSorting();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Low to High',
                  child: Text('Price: Low to High'),
                ),
                const PopupMenuItem<String>(
                  value: 'High to Low',
                  child: Text('Price: High to Low'),
                ),
                const PopupMenuItem<String>(
                  value: 'Show All Products',
                  child: Text('Show All Products'),
                ),
              ],
            ),

          ],
        ),
        body: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio:
                    1.2,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to product detail page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Product Image
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Show a loading indicator
                            errorWidget: (context, url, error) => Icon(Icons.error), // Show an error icon if image fails to load
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Product Title
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Product Price
                        Text(
                          '₹ ${product.price.toString()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }));
  }
}
