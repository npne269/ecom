import 'package:flutter/material.dart';

class CartProducts extends StatelessWidget {
  final List cartProducts = [
    {
      'name': 'Blazers',
      'picture': 'images/products/blazer2.jpeg',
      'quantity': 1,
      'size': 'M',
      'color': 'Blue',
      'price': 12
    },
    {
      'name': 'Shoe',
      'picture': 'images/products/hills2.jpeg',
      'quantity': 1,
      'size': 'M',
      'color': 'Red',
      'price': 12
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) => CartProductTile(
        cartProdName: cartProducts[i]['name'],
        cartProdColor: cartProducts[i]['color'],
        cartProdPicture: cartProducts[i]['picture'],
        cartProdPrice: cartProducts[i]['price'],
        cartProdQuantity: cartProducts[i]['quantity'],
        cartProdSize: cartProducts[i]['size'],
      ),
      itemCount: cartProducts.length,
    );
  }
}

class CartProductTile extends StatelessWidget {
  final String cartProdName;
  final String cartProdPicture;
  final String cartProdColor;
  final String cartProdSize;
  final int cartProdQuantity;
  final int cartProdPrice;

  const CartProductTile(
      {this.cartProdName,
      this.cartProdPicture,
      this.cartProdColor,
      this.cartProdSize,
      this.cartProdQuantity,
      this.cartProdPrice});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cartProdPicture,
          width: 80,
          height: 100,
        ),
        title: Text(cartProdName),
        subtitle: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Size:'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        cartProdSize,
                        style: TextStyle(color: Color(0xffa40000)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Color:'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        cartProdColor,
                        style: TextStyle(color: Color(0xffa40000)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$$cartProdPrice',
                style: TextStyle(color: Color(0xffa40000), fontSize: 17),
              ),
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                  onTap: () => print('up'), child: Icon(Icons.arrow_drop_up)),
            ),
            Flexible(child: Text('$cartProdQuantity')),
            Flexible(
              child: GestureDetector(
                  onTap: () => print('dwn'), child: Icon(Icons.arrow_drop_down)),
            ),
          ],
        ),
      ),
    );
  }
}
