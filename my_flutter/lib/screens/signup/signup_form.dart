import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/main.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/services/auth_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? surname;
  String? email;
  String? password;
  String? confirm_password;
  bool loggedin = true;
  List<String?> errors = [];

  Future<String> signIn() async {
    errors = [];
    //prima di tutto controllo se i campi sono stati lasciati vuoti
    if (email == null || email == "" || password == null || password == "") {
      return "";
    }

    String response = await signInService(email!, password!);
    print("eseguo la login e ricevo:");
    print(response);
    //la funzione signInService va a verificare se le credenziali sono corrette nel db
    //la chiamo solo se le credenziali non sono vuote

    if (response.contains('Error')) {
      String error = response;
      //errore in caso di credenziali errate
      addError(error: error);
    } else {
      String jwt = response;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', jwt);
      prefs.setString('email', email!);
      return jwt;
    }
    return '';
  }

  Future<String> signUp() async {
    if (name == null ||
        surname == null ||
        email == null ||
        password == null ||
        confirm_password == null) {
      return '';
    }
    errors = [];
    String response = await signUpService(
        name!, surname!, email!, password!, confirm_password!);

    if (response.contains('Error')) {
      String error = response;
      addError(error: error);
      print(errors);
    } else {
      String jwt = response;
      return jwt;
    }

    return '';
  }

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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSurnameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kLightOrange,
            ),
            child: const Text('Continue'),
            onPressed: () async {
              jwt = await signUp();
              if (jwt!.isNotEmpty) {
                jwt = await signIn();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('rememberMe', true);
                Navigator.pushNamed(context, SignUpOptionalScreen.routeName);
              }
              if (!_formKey.currentState!.validate()) {
                //_formKey.currentState!.save();
                print("sign up form not valid");
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        confirm_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(shortPw)) {
          return "This password is too weak!";
        }
        if (errors.contains(notMatchingPw)) {
          return "The passwords don't match!";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.lock,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(shortPw)) {
          return "This password is too weak!";
        }
        if (errors.contains(notMatchingPw)) {
          return "The passwords don't match!";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.lock,
          ),
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
        if (errors.contains(usedEmail)) {
          return "This email is already registered";
        }
        if (errors.contains(invalidEmail)) {
          return "Please, enter a valid email";
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        name = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(invalidName)) {
          return "Please, enter a valid name";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Name",
        hintText: "Enter your name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.person,
          ),
        ),
      ),
    );
  }

  TextFormField buildSurnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => surname = newValue,
      onChanged: (value) {
        surname = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(invalidSurname)) {
          return "Please, enter a valid surname";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Surname",
        hintText: "Enter your surname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.person,
          ),
        ),
      ),
    );
  }
}
