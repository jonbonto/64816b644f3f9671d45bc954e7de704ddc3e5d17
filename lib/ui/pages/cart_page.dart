part of 'pages.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    if (cart.products.length == 0)
      return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('Pesan Sekarang'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProductListPage())),
          ),
        ),
      );

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Daftar Pesanan'),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cart.clear();
                          });
                        },
                        child: Text('Hapus Pesanan'),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 20,
                    child: ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (_, index) {
                        return CartItemCard(
                          product: cart.products[index],
                          onTap: () {
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: CartButton(
                checkout: true,
                numItem: cart.numItem,
                total: cart.totalPrice,
                onTap: () {
                  setState(() {
                    cart.clear();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProductListPage()));
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
