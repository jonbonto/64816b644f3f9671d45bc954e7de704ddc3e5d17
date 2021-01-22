part of 'widgets.dart';

class ProductList extends StatefulWidget {
  final Key key;
  final Cart cart;
  final String selectedDate;
  final Function onCartChange;

  ProductList({this.key, this.cart, this.selectedDate, this.onCartChange});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _productList = <Product>[];
  final _itemFetcher = _ItemFetcher();

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  // Triggers fecth() and then add new items or change _hasMore flag
  void _loadMore() {
    _isLoading = true;
    _itemFetcher.fetch().then((List<Product> fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _productList.addAll(fetchedList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth =
        (MediaQuery.of(context).size.width - 2.5 * defaultMargin) / 2;
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: GridView.builder(
        // Need to display a loading tile if more items are coming
        itemCount: _hasMore ? _productList.length + 2 : _productList.length,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 2,
          crossAxisSpacing: 0.5 * defaultMargin,
          mainAxisSpacing: 1.5 * defaultMargin,
        ),
        padding: EdgeInsets.all(defaultMargin),
        itemBuilder: (BuildContext context, int index) {
          if (index >= _productList.length) {
            // Don't trigger if one async loading is already under way
            if (!_isLoading) {
              _loadMore();
            }
            return SizedBox(
              height: 50,
              width: 50,
              child: SpinKitFadingCircle(
                color: accentColor3,
              ),
            );
          }
          CartItem item = CartItem(
              product: _productList[index], dateTime: widget.selectedDate);
          final quantity = widget.cart.contains(item)
              ? widget.cart.products.firstWhere((p) => p.isEqual(item)).quantity
              : 0;
          return ProductCard(
            quantity: quantity,
            width: itemWidth,
            onAddToCart: () => setState(() {
              CartServices.add(item);
              widget.onCartChange();
            }),
            onChangeQuantity: (int addition) => setState(() {
              CartServices.changeItem(item, addition);
              widget.onCartChange();
            }),
            product: _productList[index],
          );
        },
      ),
    );
  }
}

class _ItemFetcher {
  int _currentPage = 1;

  // This async function simulates fetching results from Internet, etc.
  Future<List<Product>> fetch() async {
    var products = await ProductServices.getProducts(_currentPage);

    _currentPage++;
    return products;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
