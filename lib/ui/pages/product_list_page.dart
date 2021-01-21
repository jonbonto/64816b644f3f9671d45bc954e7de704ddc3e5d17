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
    bool showCart = cart.products.length != 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kulinary"),
      ),
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
                final itemWidth =
                    (MediaQuery.of(context).size.width - 2.5 * defaultMargin) /
                        2;
                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(defaultMargin),
                  childAspectRatio: 1 / 2,
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
          buildDatePicker(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
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
              String dateInString = '${date.year}-${date.month}-${date.day}';
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  color: selectedDate == dateInString
                      ? Colors.orange
                      : Colors.grey,
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
                    selectedDate = dateInString;
                    print(selectedDate);
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
