import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyDrawer extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xffa40000),
            ),
            accountName: Text('Nitesh Neupane'),
            accountEmail: Text('developernpne@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Color(0xffa40000),),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person,color: Color(0xffa40000),),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket,color: Color(0xffa40000),),
            title: Text('My Orders'),
            onTap: () =>Navigator.popAndPushNamed(context, 'cart'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart,color: Color(0xffa40000),),
            title: Text('Shopping Cart'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite,color: Color(0xffa40000),),
            title: Text('Favourites'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.green,
            ),
            title: Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text('Log Out'),
            onTap: () async{
              print('hello');
              SharedPreferences pre = await SharedPreferences.getInstance();
              print(pre.get('username'));
              pre.clear();
              await firebaseAuth.signOut();
              await _googleSignIn.signOut();
              Navigator.pushReplacementNamed(context, '/login');
//              FirebaseUser user = await firebaseAuth.currentUser();
//              print(user);
//              print(pre.get('username'));
            },
          ),
        ],
      ),
    );
  }
}
