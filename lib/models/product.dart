part of 'models.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String brandName;
  final String packageName;
  final int price;
  final double rating;

  Product(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.brandName,
      @required this.packageName,
      @required this.price,
      @required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        brandName: json["brand_name"],
        packageName: json["package_name"],
        price: json["price"],
        rating: json["rating"],
      );

  @override
  List<Object> get props =>
      [id, name, imageUrl, brandName, packageName, price, rating];
}
