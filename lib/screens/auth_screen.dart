import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../products_provide.dart/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      child: Shimmer(
                        gradient: LinearGradient(colors: [
                          Colors.lightGreenAccent,
                          Colors.yellowAccent,
                          Colors.orangeAccent,
                          Colors.tealAccent,
                        ]),
                        child: Text(
                          'PS Cart',
                          softWrap: true,
                          style: TextStyle(
                            color:
                                Theme.of(context).accentTextTheme.title.color,
                            fontSize: 65,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  // AnimationController _controller;
  // Animation<Size> _heightAnimation;

  // @override
  // void initState() {
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 700),
  //   );
  //   _heightAnimation = Tween<Size>(
  //           begin: Size(260, 260), end: Size(500, 320))
  //       .animate(
  //     CurvedAnimation(parent: _controller,curve: Curves.linear),
  //   );
  //   // _heightAnimation.addListener(() => setState((){}));
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void _showAlertDialogue(String errorMessege) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'An Error Occurred!',
                style: TextStyle(color: Theme.of(context).errorColor),
                softWrap: true,
              ),
              content: Text(
                errorMessege,
                softWrap: true,
              ),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'),
                  elevation: 6.7,
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // signup user
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessege = 'Authentication Failed.';
      if (error.toString().contains('Email_ExiST'))
        errorMessege = 'Email already in use! Please enter another.';
      else if (error.toString().contains('INVALID_EMAIL'))
        errorMessege = 'This is not a valid Email.';
      else if (error.toString().contains('WEAK_PASSWORD'))
        errorMessege = 'This Password is too weak.';
      else if (error.toString().contains('EMAIL_NOT_FOUND'))
        errorMessege = 'Couldn/t find the user';
      else if (error.toString().contains('INVALID_PASSWORD'))
        errorMessege = 'Invalid Password.';
      _showAlertDialogue(errorMessege);
    } catch (e) {
      var errorMessege = 'Oops Something went wrong!';
      _showAlertDialogue(errorMessege);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      // _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      // _controller.reverse();
    }

  }

  @override
  Widget build(BuildContext context) {
    print("bild running...");
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: AnimatedContainer(
        
          curve: Curves.linear,
          duration: Duration(milliseconds: 800),
          
          height: _authMode == AuthMode.Signup ? 320 : 260,
          // height: _heightAnimation.value.height,
          constraints:
              BoxConstraints(minHeight:  _authMode == AuthMode.Signup ? 320 : 260,),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child:  Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child:
                          Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.button.color,
                    ),
                  FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
