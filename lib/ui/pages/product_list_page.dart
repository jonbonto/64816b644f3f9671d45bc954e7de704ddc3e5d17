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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fromStringToDate(selectedDate).dateAndDay,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Expanded(
                    child: ProductList(
                      key: Key(selectedDate),
                      cart: cart,
                      selectedDate: selectedDate,
                      onCartChange: () => setState(() {}),
                    ),
                  ),
                ],
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
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (_) => CartPage(),
                                  ),
                                )
                                .then((_) => setState(() {}));
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
                      Text('${date.dayName.substring(0, 3).toUpperCase()}'),
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
