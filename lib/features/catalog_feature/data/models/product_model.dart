//Модель продукта в каталоге 

class ProductModel {
  
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final String thumbnail;
 

  ProductModel({
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] as String,
      description: json['description'] as String,
      images: json['images'] is String 
          ? (json['images'] as String).split(',')
          : (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'images': images.join(','),
      'price': price,
      'thumbnail': thumbnail,
    };
  }
}