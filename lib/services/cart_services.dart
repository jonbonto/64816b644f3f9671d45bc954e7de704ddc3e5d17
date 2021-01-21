part of 'services.dart';

class CartServices {
  static Future<void> init() async {
    if (cartDbServices.db == null) {
      cartDbServices.init();
      await Future.delayed(Duration(milliseconds: 5000));
    }
    var items = await cartDbServices.fetchItems();
    cart.products.addAll(items);
    for (var item in items) {
      cart.numItem += item.quantity;
      cart.totalPrice += item.quantity * item.product.price;
    }
  }

  static void add(CartItem item) {
    cart.add(item);
    cartDbServices.addItem(item);
  }

  static void changeItem(CartItem item, int sum) {
    var modItem = cart.changeQuantity(item, sum);
    if (modItem.quantity == 0) {
      cartDbServices.delete(modItem);
    } else {
      cartDbServices.changeItem(modItem);
    }
  }

  static void deleteItem(CartItem item) {
    var modItem = cart.delete(item);
    cartDbServices.delete(modItem);
  }

  static void clear() {
    cart.clear();
    cartDbServices.clear();
  }

  static get cart => cart;
}
