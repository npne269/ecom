//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            images: 'images/cats/accessories.png',
            label: 'Accessories',
          ),
          Category(
            images: 'images/cats/dress.png',
            label: 'Dress',
          ),
          Category(
          images: 'images/cats/tshirt.png',
          label: 'Shirt',
        ),
          Category(
            images: 'images/cats/jeans.png',
            label: 'Jeans',
          ),
          Category(
            images: 'images/cats/formal.png',
            label: 'Formal',
          ),
          Category(
            images: 'images/cats/informal.png',
            label: 'Informal',
          ),
          Category(
            images: 'images/cats/shoe.png',
            label: 'Shoe',
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String images;
  final String label;

  const Category({this.images, this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: ListTile(
        title: Image.asset(images,height: 60),
        subtitle: Text(label,textAlign: TextAlign.center,),
      ),
    );
  }
}

