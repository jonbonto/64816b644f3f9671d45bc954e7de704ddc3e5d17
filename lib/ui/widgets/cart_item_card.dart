part of 'widgets.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function onChangeQuantity;
  final Function onDelete;

  CartItemCard({this.item, this.onChangeQuantity, this.onDelete});

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
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 0),
                    onPressed: onDelete,
                  ),
                ],
              ),
              Text('${product.packageName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp ${product.price * item.quantity}',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 120,
                    child: Row(
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
                              onPressed: null, child: Text('${item.quantity}')),
                        ),
                        Flexible(
                          flex: 1,
                          child: OutlinedButton(
                              onPressed: () {
                                onChangeQuantity(1);
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
