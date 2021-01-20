part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  final double width;
  final double ratingSize;

  ProductCard({this.product, this.onTap, this.width = 210, this.ratingSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        height: 140,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 140,
          width: width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0),
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingStars(
                  votingAverage: product.rating,
                  starSize: ratingSize,
                  fontSize: ratingSize)
            ],
          ),
        ),
      ),
    );
  }
}
