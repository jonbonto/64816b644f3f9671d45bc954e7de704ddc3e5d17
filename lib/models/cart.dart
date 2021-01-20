part of 'models.dart';

class Cart {
  List<Product> products = [];
  int numItem = 0;
  int totalPrice = 0;

  void addProduct(Product product) {
    Product addedProduct =
        products.firstWhere((p) => p.id == product.id, orElse: () => null);
    if (addedProduct != null) {
      addedProduct.quantity++;
    } else {
      product.quantity = 1;
      products.add(product);
    }
    numItem++;
    totalPrice += product.price;
  }

  void substractProduct(Product product) {
    Product subProduct = products.firstWhere((p) => p.id == product.id);
    subProduct.quantity--;
    if (subProduct.quantity == 0) products.remove(subProduct);
    numItem--;
    totalPrice -= product.price;
  }
}

Cart cart = Cart();
