part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Cart cart;
  final Product product;
  final Function onTap;
  final double width;
  final double ratingSize;
  final String selectedDate;

  ProductCard(
      {this.cart,
      this.product,
      this.onTap,
      this.width = 210,
      this.ratingSize,
      this.selectedDate});

  @override
  Widget build(BuildContext context) {
    CartItem item = CartItem(product: product, dateTime: selectedDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: width,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        RatingStars(
          votingAverage: product.rating,
        ),
        Text(product.name),
        Text(
          'by ${product.brandName} - ${product.packageName}',
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 16,
        ),
        Spacer(),
        Text('Rp ${product.price} termasuk ongkir'),
        cart.contains(item)
            ? Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: OutlinedButton(
                        onPressed: () {
                          CartServices.changeItem(item, -1);
                          onTap();
                        },
                        child: Text("-")),
                  ),
                  Flexible(
                    flex: 2,
                    child: OutlinedButton(
                        onPressed: null,
                        child: Text(
                            '${cart.products.firstWhere((p) => p.isEqual(item)).quantity}')),
                  ),
                  Flexible(
                    flex: 1,
                    child: OutlinedButton(
                        onPressed: () {
                          CartServices.changeItem(item, 1);
                          onTap();
                        },
                        child: Text("+")),
                  ),
                ],
              )
            : OutlinedButton(
                onPressed: () {
                  CartServices.add(item);
                  onTap();
                },
                child: Text("Tambah ke Keranjang"),
              ),
      ],
    );
  }
}
