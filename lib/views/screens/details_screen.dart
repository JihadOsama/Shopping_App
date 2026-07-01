import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 400),
            SizedBox(height: 16),
            Text(product.name),
            Text(
              product.price.toString(),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(product.desc),
          ],
        ),
      ),
    );
  }
}