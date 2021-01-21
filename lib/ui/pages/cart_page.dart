part of 'pages.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cart = CartServices.cart;
    if (cart.products.length == 0) return CartPageEmpty();

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Review Pesanan',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daftar Pesanan'),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            CartServices.clear();
                          });
                        },
                        child: Text('Hapus Pesanan'),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 20,
                    child: GroupedListView<CartItem, String>(
                      elements: cart.products,
                      groupBy: (element) => element.dateTime,
                      groupSeparatorBuilder: (String groupByValue) =>
                          Text(groupByValue),
                      itemBuilder: (context, CartItem element) => CartItemCard(
                        item: element,
                        onTap: () {
                          setState(() {});
                        },
                      ),
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
                    CartServices.clear();
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

class CartPageEmpty extends StatelessWidget {
  const CartPageEmpty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: 24,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: null,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Review Pesanan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/cart_empty.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text('Keranjangmu masih kosong, nih')
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultMargin),
              child: RaisedButton(
                color: Colors.deepOrange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pesan Sekarang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ProductListPage())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
