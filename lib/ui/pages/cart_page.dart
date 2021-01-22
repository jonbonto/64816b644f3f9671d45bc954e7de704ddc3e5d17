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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 120.0,
              centerTitle: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: const EdgeInsets.all(0),
                    title: AnimatedPadding(
                      duration: Duration(milliseconds: 0),
                      padding: EdgeInsets.only(left: 85 - top / 2, bottom: 16),
                      child: Text(
                        'Review Pesanan',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              elevation: 5,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        child: GroupedListView<CartItem, String>(
                          shrinkWrap: true,
                          elements: cart.products,
                          groupBy: (element) =>
                              fromStringToDate(element.dateTime)
                                  .dateAndDayShortMonth,
                          groupSeparatorBuilder: (String groupByValue) =>
                              Text(groupByValue),
                          itemBuilder: (context, CartItem element) =>
                              CartItemCard(
                            item: element,
                            onTap: () {
                              setState(() {});
                            },
                          ),
                          itemComparator: (element1, element2) =>
                              element1.product.id - element2.product.id,
                        ),
                      ),
                    ],
                  ),
                ],
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
