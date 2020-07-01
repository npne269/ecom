import 'package:flutter/material.dart';
import 'package:shopping/pages/product_details.dart';

class Product extends StatelessWidget {
  final String name;
  final String image;
  final int oldPrice;
  final int price;

  const Product({this.name, this.image, this.oldPrice, this.price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetails(
                  prodName: name,
                  prodImg: image,
                  prodPrice: price,
                  prodOldPrice: oldPrice,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white70,
                  child: Row(
                    children: <Widget>[
                      Text(
                        name,
                      ),
                      Spacer(),
                      Text(
                        "\$$price",
                        style: TextStyle(
                            color: Color(0xffa40000),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      (oldPrice != null)
                          ? Text(
                              "\$$oldPrice",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Container(),
                    ],
                  )),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
