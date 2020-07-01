import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping/pages/signupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;
  bool hidePassword = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  void loginCheck() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('id');
    isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn|| user != null) {
      Fluttertoast.showToast(msg: 'Welcome');
      Navigator.pushReplacementNamed(context, '/home');
    }
    setState(() {
      loading = false;
    });
  }
  void login(String email,String pass) async{
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      preferences = await SharedPreferences.getInstance();
        _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).catchError((e){
          Fluttertoast.showToast(msg: '${e.message}');
        }).then((v){
          preferences.setString('id', v.user.uid);
          Fluttertoast.showToast(msg: 'Successfully Signed up');
          Navigator.pushReplacementNamed(context, '/home');
        });
      setState(() {
        loading = false;
      });
      }

  }

  void googleSignIn() async {
    setState(() {
      loading = true;
    });
    GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await signInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken);
    preferences = await SharedPreferences.getInstance();
    FirebaseUser firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      List<DocumentSnapshot> document = result.documents;
      if (document.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'profilePicture': firebaseUser.photoUrl,
          'email':firebaseUser.email,
        });
        await preferences.setString('id', firebaseUser.uid);
      } else {
        await preferences.setString('id', document[0]['id']);
      }
      Fluttertoast.showToast(msg: 'Login was successful');
      setState(() {
        loading = false;
      });
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Fluttertoast.showToast(msg: 'Login was Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _email,
                        validator: (v) {
                          if (v.contains("@") && v.endsWith('.com')) {
                            return null;
                          } else {
                            return "Please Enter valid Address";
                          }

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (v) {
                          String pattern =
                              r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                          if (v.isNotEmpty && v.contains(RegExp(pattern))) {
                            return null;
                          } else {
                            return 'Password must contains at least 8 characters with numbers.';
                          }
                        },
                        controller: _pass,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon((hidePassword)
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          textColor: Colors.grey,
                          onPressed: () {},
                          child: Text('Forget password?'),
                        ),
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        textColor: Colors.white,
                        color: Colors.indigo,
                        child: Text('Log in'),
                        onPressed: ()=> login(
                          _email.text,_pass.text
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignUpPage()));
                              },
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold))
                      ]),
//                      textAlign: ,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton.icon(
                  icon: Icon(Icons.language),
                  color: Color(0xffa40000),
                  textColor: Colors.white,
                  label: Text('Or Login with Google'),
                  onPressed: () => googleSignIn(),
                ),
              ),
            ],
          ),
          Visibility(
            visible: loading,
            child: Container(
              color: Colors.white70,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
