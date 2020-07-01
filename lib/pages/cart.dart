import 'package:flutter/material.dart';
import 'package:shopping/components/cart_products.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xffa40000),
        title: Text('Fashapp'),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: CartProducts(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total:'),
                subtitle: Text('\$12',style: TextStyle(fontSize: 17,color: Color(0xffa40000) ),),
              ),
            ),
            Expanded(
              child: RaisedButton(onPressed: (){},textColor: Colors.white,child: Text('Checkout'),color: Color(0xffa40000),),
            ),
          ],
        ),
      ),
    );
  }
}
