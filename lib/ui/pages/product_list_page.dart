part of 'pages.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    bool showCart = cart.products.length != 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kulinary"),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Product>>(
              future: ProductServices.getProducts(1),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return SizedBox(
                    height: 50,
                    width: 50,
                    child: SpinKitFadingCircle(
                      color: accentColor3,
                    ),
                  );
                var products = snapshot.data;
                final itemWidth =
                    (MediaQuery.of(context).size.width - 2.5 * defaultMargin) /
                        2;
                final itemHeight = 305;
                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(defaultMargin),
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 0.5 * defaultMargin,
                  mainAxisSpacing: 1.5 * defaultMargin,
                  children: List.generate(products.length, (index) {
                    return ProductCard(
                      cart: cart,
                      width: itemWidth,
                      onTap: () => setState(() {}),
                      product: products[index],
                    );
                  }),
                );
              }),
          showCart
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultMargin),
                    child: CartButton(
                        numItem: cart.numItem,
                        total: cart.totalPrice,
                        onTap: () {
                          print("go to cart screen");
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => CartPage()));
                        }),
                  ),
                )
              : SizedBox(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
