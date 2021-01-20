part of 'widgets.dart';

class CartButton extends StatelessWidget {
  final int numItem;
  final int total;
  final Function onTap;
  final bool checkout;

  const CartButton(
      {this.numItem, this.total, this.onTap, this.checkout = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: RaisedButton(
        color: mainColor,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$numItem Item | Rp $total'),
                Text('Termasuk ongkos kirim'),
              ],
            ),
            checkout
                ? Text('CHECKOUT >')
                : Icon(
                    Icons.shop,
                  )
          ],
        ),
      ),
    );
  }
}
