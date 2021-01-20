part of 'services.dart';

class ProductServices {
  static Future<List<Product>> getProducts(int page,
      {http.Client client}) async {
    String url =
        'https://kulina-recruitment.herokuapp.com/products?_page=$page&_limit=10';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }
    var result = json.decode(response.body) as List;

    return result.map((e) => Product.fromJson(e)).toList();
  }
}
