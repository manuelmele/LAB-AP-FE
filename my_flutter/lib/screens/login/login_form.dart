import 'package:flutter/material.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/services/auth_service.dart';
//import 'package:shop_app/components/custom_surfix_icon.dart';
//import 'package:shop_app/components/form_error.dart';
//import 'package:shop_app/helper/keyboard.dart';
//import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
//import 'package:shop_app/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

  bool _passwordVisible = false; //makes the password readable or dotted
  //note the underscore in front of the variable name means that the variable is private to this file

  Future<String> signIn() async {
    if (email == null || password == null) return '';

    String response = await signInService(email!, password!);

    //print(response);

    if (response.contains('Error')) {
      String error = response;
      print(error);
      //errors.add(error);
    } else {
      String jwt = response;
      return jwt;
    }

    return '';
  }

  @override
  void initState() {
    _passwordVisible = false; //setta inizialmente la password oscurata
  }

  final List<String?> errors = [];

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
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"), //for remaining the current session
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Intro.routeName);
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
              child: const Text('Login'),
              onPressed: () async {
                //print(email! + " - " + password!);
                String jwt = await signIn();

                if (jwt.isNotEmpty) {
                  Navigator.pushNamed(context, NavigatorScreen.routeName);
                }
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
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
        if (value.isNotEmpty) {
          removeError(error: "Please, enter your password!");
        } //else if (value.length >= 8) {
        //removeError(error: "Your password is too short!");
        //}
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Please, enter your password!");
          return "";
        } //else if (value.length < 8) {
        //addError(error: "Your password is too short!");
        //return "";
        //}
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
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
        if (value.isNotEmpty) {
          removeError(error: "Please, enter your email!");
        } //else if (emailValidatorRegExp.hasMatch(value)) {
        //removeError(error: "Please, enter valid email!");
        //}
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Please, enter your email!");
          return "";
        } //else if (!emailValidatorRegExp.hasMatch(value)) {
        //addError(error: "Please, enter valid email!");
        //return "";
        //}
        return null;
      },
      decoration: const InputDecoration(
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
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
