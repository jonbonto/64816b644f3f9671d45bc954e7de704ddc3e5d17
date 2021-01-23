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
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              elevation: 5,
              iconTheme: IconThemeData(
                color: Colors.black87,
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
                          Text(
                            'Daftar Pesanan',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  CartServices.clear();
                                });
                              },
                              child: Text(
                                'Hapus Pesanan',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      Container(
                        child: GroupedListView<CartItem, String>(
                          shrinkWrap: true,
                          elements: cart.products,
                          groupBy: (element) => element.dateTime,
                          groupSeparatorBuilder: (String groupByValue) => Text(
                              fromStringToDate(groupByValue)
                                  .dateAndDayShortMonth),
                          itemBuilder: (context, CartItem item) => CartItemCard(
                            item: item,
                            onChangeQuantity: (int sum) {
                              setState(() {
                                CartServices.changeItem(item, sum);
                              });
                            },
                            onDelete: () {
                              setState(() {
                                CartServices.deleteItem(item);
                              });
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
                    CartServices.clear();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProductListPage()));
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
