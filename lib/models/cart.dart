part of 'models.dart';

class Cart {
  List<CartItem> products = [];
  int numItem = 0;
  int totalPrice = 0;

  void add(CartItem item) {
    products.add(item);
    numItem++;
    totalPrice += item.product.price;
  }

  void changeQuantity(CartItem item, int sum) {
    CartItem subProduct = products.firstWhere((p) => p.isEqual(item));
    subProduct.quantity += sum;
    if (subProduct.quantity == 0) products.remove(subProduct);
    numItem += sum;
    totalPrice += subProduct.product.price * sum;
  }

  void delete(CartItem item) {
    CartItem deletedItem = products.firstWhere((p) => p.isEqual(item));
    numItem -= deletedItem.quantity;
    totalPrice -= item.product.price * deletedItem.quantity;

    products.remove(deletedItem);
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

  bool isEqual(CartItem other) =>
      product.id == other.product.id && dateTime == other.dateTime;
}

Cart cart = Cart();
