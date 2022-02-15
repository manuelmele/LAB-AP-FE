import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/services/auth_service.dart';
import 'package:wefix/constants.dart';

//import 'package:form_field_validator/form_field_validator.dart';
//import 'package:shop_app/components/custom_surfix_icon.dart';
//import 'package:shop_app/components/form_error.dart';
//import 'package:shop_app/helper/keyboard.dart';
//import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
//import 'package:shop_app/screens/login_success/login_success_screen.dart';

import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? _rememberMe = false;

  bool _passwordVisible = false; //makes the password readable or dotted
  //note the underscore in front of the variable name means that the variable is private to this file

  //funzione che verifica le credenziali
  Future<String> signIn() async {
    errors = [];
    //prima di tutto controllo se i campi sono stati lasciati vuoti
    if (email == null || email == "" || password == null || password == "") {
      return "";
    }

    String response = await signInService(email!, password!);
    //la funzione signInService va a verificare se le credenziali sono corrette nel db
    //la chiamo solo se le credenziali non sono vuote

    if (response.contains('Error')) {
      String error = response;
      //errore in caso di credenziali errate
      addError(error: error);
    } else {
      String jwt = response;
      return jwt;
    }
    return '';
  }

  @override
  void initState() {
    _passwordVisible = false; //setta inizialmente la password oscurata
    //_loadUserEmailPassword();
    super.initState();
  }

  List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  //mi sa che è inutile si può cancellare
  void _handleRemeberme(bool value) {
    _rememberMe = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', email!);
        prefs.setString('password', password!);
      },
    );
    setState(() {
      _rememberMe = value;
    });
  }

  //mi sa che pure questa  è inutile e si può cancellare
  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (_remeberMe) {
        setState(() {
          _rememberMe = true;
        });
        email = _email;
        password = _password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                activeColor: kLightOrange,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
              const Text("Remember me"), //for remaining the current session
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Intro.routeName);
                }, //add forgotpasswordScreen.routeName and .dart
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kLightOrange,
              ),
              child: const Text('Login'),
              onPressed: () async {
                //chiama la funzione signin per verificare le credenziali
                //signin ritorna "" se c'è qualche problema
                String jwt = await signIn();
                print(jwt);
                if (jwt.isNotEmpty) {
                  if (_rememberMe == true) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('jwt', jwt);
                  }
                  Navigator.pushReplacementNamed(
                      context, NavigatorScreen.routeName);
                }
                //chiamo la funzione validate per mostrare gli errori a schermo
                if (!_formKey.currentState!.validate()) {
                  print("login form not valid");
                }
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
            }, //add forgotpasswordScreen.routeName and .dart
            child: const Text(
              "Don't have an account? Sign up",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(wrong)) {
          return "Invalid email or password";
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),

        labelText: "Password",
        //focusColor: kOrange,
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            //cambia l'icona in base alla visibility della pw
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible =
                  !_passwordVisible; //switcha tra password oscurata e password visibile
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(wrong)) {
          return "Invalid email or password";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Email",
        hintText: "Enter your email",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.email,
          ),
        ),
      ),
    );
  }
}
