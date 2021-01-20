part of 'widgets.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final Function onTap;

  CartItemCard({this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 120, child: Text(product.name)),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cart.delete(product);
                          onTap();
                        }),
                  ],
                ),
                Text(
                  '${product.packageName}',
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rp ${product.price * product.quantity}'),
                    Container(
                      width: 120,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: OutlinedButton(
                                onPressed: () {
                                  cart.substractProduct(product);
                                  onTap();
                                },
                                child: Text("-")),
                          ),
                          Flexible(
                            flex: 2,
                            child: OutlinedButton(
                                onPressed: null,
                                child: Text(
                                    '${cart.products.firstWhere((p) => p.id == product.id).quantity}')),
                          ),
                          Flexible(
                            flex: 1,
                            child: OutlinedButton(
                                onPressed: () {
                                  cart.addProduct(product);
                                  onTap();
                                },
                                child: Text("+")),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
