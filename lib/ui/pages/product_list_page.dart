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
    while (now.weekday == 6 || now.weekday == 7) {
      // skip sabtu minggu
      now = now.add(Duration(days: 1));
    }
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
                        style: TextStyle(fontSize: 14.0, color: Colors.black87),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        fromStringToDate(selectedDate).dateAndDay,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  final CarouselController _controller = CarouselController();

  Widget buildDatePicker() {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: now.weekday - 1));

    List<Widget> items = [];

    for (var index = 0; index < 8; index++) {
      var children = List<Widget>.generate(7, (ind) {
        DateTime date = startDate.add(Duration(days: 7 * index + ind));
        var isDisabled =
            date.isBefore(now) || date.weekday == 6 || date.weekday == 7;
        var selected = selectedDate == date.dateInString;
        Color textColor = selected
            ? Theme.of(context).accentColor
            : isDisabled
                ? Theme.of(context).disabledColor
                : Colors.black87;
        return GestureDetector(
          child: Container(
            width: (MediaQuery.of(context).size.width - 72) / 7,
            decoration: (selected)
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
            color: (selected) ? null : Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.dayName.substring(0, 3).toUpperCase()}',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          onTap: isDisabled
              ? null
              : () {
                  setState(() {
                    selectedDate = date.dateInString;
                  });
                },
        );
      });

      items.add(Row(
        children: children,
      ));
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: CarouselSlider(
            items: items,
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 60,
                viewportFraction: 1,
                enableInfiniteScroll: false),
            carouselController: _controller,
          ),
        ),
        Align(
          alignment: Alignment(-1.1, 0),
          child: FlatButton(
            onPressed: () => _controller.previousPage(),
            child: Icon(Icons.arrow_back,
                size: 24, color: Colors.deepOrangeAccent),
            shape: CircleBorder(),
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment(1.1, 0),
          child: FlatButton(
            onPressed: () => _controller.nextPage(),
            child: Icon(Icons.arrow_forward,
                size: 24, color: Colors.deepOrangeAccent),
            shape: CircleBorder(),
            color: Colors.white,
          ),
        ),
      ],
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
