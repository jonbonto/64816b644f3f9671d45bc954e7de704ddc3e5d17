part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  final double width;
  final double ratingSize;

  ProductCard({this.product, this.onTap, this.width = 210, this.ratingSize});

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
        OutlinedButton(
          onPressed: onTap,
          child: Text("Tambah ke Keranjang"),
        ),
      ],
    );
  }
}
