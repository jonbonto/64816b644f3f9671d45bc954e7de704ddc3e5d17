part of 'services.dart';

class CartServices {
  static final _cart = Cart();
  static Future<void> init() async {
    var items = await cartDbServices.fetchItems();
    _cart.products.addAll(items);
    for (var item in items) {
      _cart.numItem += item.quantity;
      _cart.totalPrice += item.quantity * item.product.price;
    }
  }

  static void add(CartItem item) {
    _cart.add(item);
    cartDbServices.addItem(item);
  }

  static void changeItem(CartItem item, int sum) {
    var modItem = _cart.changeQuantity(item, sum);
    if (modItem.quantity == 0) {
      cartDbServices.delete(modItem);
    } else {
      cartDbServices.changeItem(modItem);
    }
  }

  static void deleteItem(CartItem item) {
    var modItem = _cart.delete(item);
    cartDbServices.delete(modItem);
  }

  static void clear() {
    _cart.clear();
    cartDbServices.clear();
  }

  static Cart get cart => _cart;
}
