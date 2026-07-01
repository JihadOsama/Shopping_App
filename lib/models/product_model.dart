class ProductModel {
  final int id;
  final int price;
  final String name;
  final String imageUrl;
  final String desc;

  ProductModel({
    required this.id,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.desc,
  });
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      price: data['price'],
      name: data['name'],
      imageUrl: data['imageUrl'],
      desc: data['description'],
    );
  }
}

class ProductResponse {
  final List<ProductModel> response;

  ProductResponse({required this.response});
  factory ProductResponse.fromJson(Map<String, dynamic> data) {
    return ProductResponse(
      response: (data['response'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
    );
  }
}