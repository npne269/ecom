import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/components/horizontal_listview.dart';
import 'package:shopping/components/myDrawer.dart';
import 'package:shopping/components/products.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void user() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    String currentUser = pref.getString('id');
    print('welcome $currentUser,also ${fUser.uid}');
  }

  @override
  void initState() {
    super.initState();
    user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
            width: 20,
          ),
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, 'cart'),
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Carousel(
              boxFit: BoxFit.cover,
              images: [
                AssetImage('images/c1.jpg'),
                AssetImage('images/m1.jpeg'),
                AssetImage('images/w1.jpeg'),
                AssetImage('images/w3.jpeg'),
                AssetImage('images/w4.jpeg'),
              ],
              dotSize: 4.0,
              indicatorBgPadding: 4.0,
              dotBgColor: Colors.transparent,
            ),
          ),
          TopicTitle(title: 'Categories',),
          HorizontalList(),
          TopicTitle(title: 'Products',),
          Expanded(child: Products())
        ],
      ),
    );
  }
}

class TopicTitle extends StatelessWidget {
  final String title;
  const TopicTitle({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
