part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onAddToCart;
  final Function onChangeQuantity;
  final double width;
  final double ratingSize;
  final int quantity;

  ProductCard({
    this.product,
    this.onAddToCart,
    this.onChangeQuantity,
    this.width = 210,
    this.ratingSize,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
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
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'by ${product.brandName} - ${product.packageName}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(
          height: 16,
        ),
        Spacer(),
        Text('Rp ${product.price} termasuk ongkir'),
        quantity != 0
            ? Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: OutlinedButton(
                        onPressed: () {
                          onChangeQuantity(-1);
                        },
                        child: Text("-")),
                  ),
                  Flexible(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: null,
                      child: Text('$quantity'),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        onChangeQuantity(1);
                      },
                      child: Text("+"),
                    ),
                  ),
                ],
              )
            : OutlinedButton(
                onPressed: onAddToCart,
                child: Text("Tambah ke Keranjang"),
              ),
      ],
    );
  }
}
