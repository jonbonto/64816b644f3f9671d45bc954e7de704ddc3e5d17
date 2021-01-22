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
    var newProduct = product.rating == 0 || product.rating == null;
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: newProduct
              ? Chip(label: Text('BARU'), backgroundColor: Colors.lightGreen)
              : RatingStars(
                  votingAverage: product.rating,
                ),
        ),
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          'by ${product.brandName}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          '${product.packageName}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Spacer(),
        Row(
          children: [
            Text(
              'Rp ${product.price}',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'termasuk ongkir',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
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
                      child: Text(
                        '$quantity',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
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
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
