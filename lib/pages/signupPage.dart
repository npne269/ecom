import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/db/users.dart';

enum Gender { male, female }

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserServices _userServices = UserServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  bool isLoggedIn = false;
  bool hidePassword = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _pass1 = TextEditingController();
  Gender _gender = Gender.male;
  final _formKey = GlobalKey<FormState>();

  void setGender(val) {
    setState(() {
      _gender = val;
    });
    print(_gender);
  }

  void signUp() async {
    {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        loading = true;
      });
      if (_formKey.currentState.validate()) {
        FirebaseUser user = await firebaseAuth.currentUser();
        if (user == null) {
          firebaseAuth
              .createUserWithEmailAndPassword(
                  email: _email.text, password: _pass.text)
              .catchError((e) {
            Fluttertoast.showToast(msg: '${e.message}');
          }).then((value) {
            _userServices.createUser(value.user.uid, {
              'id': value.user.uid,
              'username': _name.text,
              'email': _email.text,
              'gender': _gender.toString(),
            });
            pref.setString('id', value.user.uid);
            Fluttertoast.showToast(msg: 'Successfully Signed up');
            Navigator.pushReplacementNamed(context, '/home');
          });
          
        } else {
          print(user);
          print('user is not null');
        }
      }
    }
    setState(() {
      loading = false;
    });
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
                  'Sign Up',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _name,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return "Name field cannot be empty";
                          }
                          return null;
                        }),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: Gender.male,
                          groupValue: _gender,
                          onChanged: (val) => setGender(val),
                        ),
                        Text('Male'),
                        Spacer(),
                        Radio(
                          value: Gender.female,
                          groupValue: _gender,
                          onChanged: (val) => setGender(val),
                        ),
                        Text('Female'),
                      ],
                    ),
                    TextFormField(
                      controller: _email,
                      validator: (v) {
                        if (v.contains("@") && v.endsWith('.com')) {
                          return null;
                        } else {
                          return "Please Enter valid Address";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
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
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (v) {
                        if (_pass.value.text != v) {
                          return "Your password didn't match";
                        }
                        return null;
                      },
                      controller: _pass1,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon((hidePassword)
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: Text('Sign in'),
                      onPressed: () => signUp(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Log In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold))
                      ]),
//                      textAlign: ,
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
