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
      'images': product.images,
      'price': product.price,
      'thumbnail': product.thumbnail,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json),
      quantity: json['quantity'] as int? ?? 1,
    );
  }
} 