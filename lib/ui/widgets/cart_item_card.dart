part of 'widgets.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function onTap;

  CartItemCard({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    Product product = item.product;
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
                        cart.delete(item);
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
                  Text('Rp ${product.price * item.quantity}'),
                  Container(
                    width: 120,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: OutlinedButton(
                              onPressed: () {
                                cart.changeQuantity(item, -1);
                                onTap();
                              },
                              child: Text("-")),
                        ),
                        Flexible(
                          flex: 2,
                          child: OutlinedButton(
                              onPressed: null, child: Text('${item.quantity}')),
                        ),
                        Flexible(
                          flex: 1,
                          child: OutlinedButton(
                              onPressed: () {
                                cart.changeQuantity(item, 1);
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
          ),
        ),
      ],
    );
  }
}
