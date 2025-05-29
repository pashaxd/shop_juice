import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';

//Модель продукта в корзине

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': product.title,
      'description': product.description,
      'images': product.images.join(','),
      'price': product.price.toString(),
      'thumbnail': product.thumbnail,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // Handle images that could be either String or Uint8Array
    List<String> imagesList;
    if (json['images'] is String) {
      imagesList = (json['images'] as String).split(',');
    } else if (json['images'] is List) {
      imagesList = (json['images'] as List).map((e) => e.toString()).toList();
    } else {
      // If it's a Uint8Array or other format, convert to string first
      imagesList = [json['images'].toString()];
    }

    return CartItemModel(
      product: ProductModel(
        title: json['title'] as String,
        description: json['description'] as String,
        images: imagesList,
        price: (json['price'] as num).toDouble(),
        thumbnail: json['thumbnail'] as String,
      ),
      quantity: json['quantity'] as int? ?? 1,
    );
  }
} 