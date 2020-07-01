import 'package:flutter/material.dart';
import 'package:shopping/components/single_prod_ui.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List _products = [
    {
      'name':'Blazer',
      'image':'images/products/blazer1.jpeg',
//      'old_price':120,
      'new_price':85
    },
    {
      'name':'Red dress',
      'image':'images/products/dress1.jpeg',
      'old_price':100,
      'new_price':50
    },
    {
      'name':'Hills',
      'image':'images/products/hills1.jpeg',
      'old_price':60,
      'new_price':40
    },
    {
      'name':'Pants',
      'image':'images/products/pants1.jpg',
      'old_price':10,
      'new_price':20
    },
    {
      'name':'Shoe',
      'image':'images/products/shoe1.jpg',
      'old_price':30,
      'new_price':20
    },
    {
      'name':'Skirts',
      'image':'images/products/skt1.jpeg',
      'old_price':60,
      'new_price':40
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_,i)=>Product(
          name: _products[i]['name'],
          image: _products[i]['image'],
          oldPrice: _products[i]['old_price'],
          price: _products[i]['new_price'],
        ));
  }
}

