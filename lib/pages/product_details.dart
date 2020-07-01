import 'package:flutter/material.dart';
import 'package:shopping/components/single_prod_ui.dart';

class ProductDetails extends StatefulWidget {
  final String prodName;
  final String prodImg;
  final int prodPrice;
  final int prodOldPrice;

  const ProductDetails(
      {this.prodName, this.prodImg, this.prodPrice, this.prodOldPrice});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future<bool> _navToHome(c){
    if(true){
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    }
    return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_navToHome(context),
      child: Scaffold(
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
        body: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: GridTile(
                footer: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    color: Colors.white70,
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.prodName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          "\$${widget.prodPrice}",
                          style: TextStyle(
                              color: Color(0xffa40000),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "\$${widget.prodOldPrice}",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    )),
                child: Image.asset(widget.prodImg),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SCQ(
                    title: 'Size',
                  ),
                ),
                Expanded(
                  child: SCQ(
                    title: 'Colors',
                  ),
                ),
                Expanded(
                  child: SCQ(
                    title: 'Qty',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xffa40000),
                      textColor: Colors.white,
                      child: Text('Buy Now'),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Color(0xffa40000),
                      ),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Color(0xffa40000),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Product Details'),
              subtitle: Text(
                  'Me: What’s the Wi-Fi password? Bartender: You need to buy a drink first. Me: OK, I’ll have a Coke. Bartender: Three dollars. Me: There you go. So what’s the Wi‑Fi password? Bartender: “You need to buy a drink first.” No spaces, all lowercase.'),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: <Widget>[
                  Text(
                    'Product Name: ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.prodName),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: <Widget>[
                  Text(
                    'Product Brand: ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Prod brand'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: <Widget>[
                  Text(
                    'Product Condition: ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Prod condition')
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Similar Products'),
            ),
            Container(height: 200, child: SimilarProducts())
          ],
        ),
      ),
    );
  }
}

class SimilarProducts extends StatelessWidget {
  final List _products = [
    {
      'name': 'Shoe',
      'image': 'images/products/shoe1.jpg',
      'old_price': 30,
      'new_price': 20
    },
    {
      'name': 'Skirts',
      'image': 'images/products/skt1.jpeg',
      'old_price': 60,
      'new_price': 40
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: _products.length,
      itemBuilder: (_, i) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 200,
        child: Product(
          name: _products[i]['name'],
          image: _products[i]['image'],
          oldPrice: _products[i]['old_price'],
          price: _products[i]['new_price'],
        ),
      ),
    );
  }
}

class SCQ extends StatelessWidget {
  final String title;

  const SCQ({this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text('Choose the ${title.toLowerCase()} :'),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            );
          }),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }
}
