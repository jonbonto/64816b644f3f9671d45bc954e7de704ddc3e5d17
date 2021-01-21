part of 'pages.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String selectedDate;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedDate = '${now.year}-${now.month}-${now.day}';
    initCart();
  }

  void initCart() async {
    await CartServices.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var cart = CartServices.cart;
    bool showCart = cart.products.length != 0;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 60.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(top: 20.0, left: 48),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alamat Pengiriman',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        "Kulina",
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                leading: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.white,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(60.0),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: buildDatePicker(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              FutureBuilder<List<Product>>(
                future: ProductServices.getProducts(getPage(selectedDate)),
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
                  final itemWidth = (MediaQuery.of(context).size.width -
                          2.5 * defaultMargin) /
                      2;

                  return GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(defaultMargin),
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 0.5 * defaultMargin,
                    mainAxisSpacing: 1.5 * defaultMargin,
                    children: List.generate(
                      products.length,
                      (index) {
                        CartItem item = CartItem(
                            product: products[index], dateTime: selectedDate);
                        final quantity = cart.contains(item)
                            ? cart.products
                                .firstWhere((p) => p.isEqual(item))
                                .quantity
                            : 0;
                        return ProductCard(
                          quantity: quantity,
                          width: itemWidth,
                          onAddToCart: () => setState(() {
                            CartServices.add(item);
                          }),
                          onChangeQuantity: (int addition) => setState(() {
                            CartServices.changeItem(item, addition);
                          }),
                          product: products[index],
                        );
                      },
                    ),
                  );
                },
              ),
              showCart
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultMargin),
                        child: CartButton(
                          numItem: cart.numItem,
                          total: cart.totalPrice,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CartPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: now.weekday - 1));
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (_, index) {
          return Row(
            children: List<Widget>.generate(7, (ind) {
              DateTime date = startDate.add(Duration(days: 7 * index + ind));
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  decoration: (selectedDate == date.dateInString)
                      ? BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment(0, 0.6),
                            colors: [
                              Colors.deepOrange[300],
                              Colors.white,
                            ],
                          ),
                        )
                      : null,
                  color: (selectedDate == date.dateInString)
                      ? null
                      : Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${date.shortDayName}'),
                      Text('${date.day}'),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedDate = date.dateInString;
                  });
                },
              );
            }),
          );
        },
      ),
    );
  }

  int getPage(String date) {
    DateTime start = DateTime(2021);
    var dateSplited = date.split('-').map(int.parse).toList();
    return DateTime(dateSplited[0], dateSplited[1], dateSplited[2])
                .difference(start)
                .inDays %
            3 +
        1;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
