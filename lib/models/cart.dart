part of 'models.dart';

class Cart {
  List<CartItem> products = [];
  int numItem = 0;
  int totalPrice = 0;

  CartItem add(CartItem item) {
    products.add(item);
    numItem++;
    totalPrice += item.product.price;
    return item;
  }

  CartItem changeQuantity(CartItem item, int sum) {
    CartItem modItem = products.firstWhere((p) => p.isEqual(item));
    modItem.quantity += sum;
    if (modItem.quantity == 0) products.remove(modItem);
    numItem += sum;
    totalPrice += modItem.product.price * sum;
    return modItem;
  }

  CartItem delete(CartItem item) {
    CartItem deletedItem = products.firstWhere((p) => p.isEqual(item));
    numItem -= deletedItem.quantity;
    totalPrice -= item.product.price * deletedItem.quantity;

    products.remove(deletedItem);
    return deletedItem;
  }

  void clear() {
    products = [];
    numItem = 0;
    totalPrice = 0;
  }

  bool contains(CartItem item) => products.any((p) => p.isEqual(item));
}

class CartItem {
  Product product;
  int quantity = 1;
  String dateTime;

  CartItem({this.product, this.dateTime});

  factory CartItem.fromDb(Map<String, dynamic> json) {
    var quantity = json['quantity'];
    var dateTime = json['date'];
    Product product = Product(
      id: json['product_id'],
      name: json["name"],
      imageUrl: json["image_url"],
      brandName: json["brand_name"],
      packageName: json["package_name"],
      price: json["price"],
      rating: json["rating"],
    );
    CartItem item = CartItem(product: product, dateTime: dateTime);
    item.quantity = quantity;
    return item;
  }

  Map<String, dynamic> toMap({bool id = true}) {
    var maps = <String, dynamic>{
      "date": dateTime,
      "quantity": quantity,
      "product_id": product.id,
      "price": product.price,
      "name": product.name,
      "brand_name": product.brandName,
      "package_name": product.packageName,
      "image_url": product.imageUrl,
      "rating": product.rating,
    };
    if (id) maps['id'] = '${product.id}-$dateTime';
    return maps;
  }

  bool isEqual(CartItem other) =>
      product.id == other.product.id && dateTime == other.dateTime;
}
