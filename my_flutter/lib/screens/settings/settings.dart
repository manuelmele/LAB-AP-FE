import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:wefix/screens/payment/body.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/services/user_service.dart';
import 'package:wefix/size_config.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String? name;
  String? surname;
  String? email;
  String? jwt;
  var role;
  var data;
  UserModel? userData;
  bool initialResults = false;

  String? oldPassword;
  String? newPassword;
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  List<String?> errors = [];

  Future<String> changePassword() async {
    errors = [];
    //prima di tutto controllo se i campi sono stati lasciati vuoti
    if (oldPassword == null ||
        oldPassword == "" ||
        newPassword == null ||
        newPassword == "") {
      return "";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString('jwt');

    String response =
        await changePasswordService(jwt!, oldPassword!, newPassword!);
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

  //CODICE PRESO DA MANUEL
  void getUserData() {
    //search by category just the first time
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((newResults) {
        setState(() {
          userData = newResults;
          initialResults = true;
          print(userData);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Drawer(
      backgroundColor: kBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(200),
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: kLightGreen,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: userData == null
                          ? null
                          : Image.memory(base64Decode(userData!.photoProfile))
                              .image,
                      radius: getProportionateScreenHeight(40),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(userData == null
                        ? ""
                        : userData!.firstName +
                            " " +
                            userData!.secondName +
                            "\n" +
                            userData!.email),
                  ]),
            ),
          ),
          ListTile(
            title: role == null
                ? const Text('Upgrade to PRO')
                : const Text('Manage your subscription'),
            iconColor: kOrange,
            textColor: kOrange,
            //subtitle: const Text('subscribe now to enjoy all the benefits'),
            trailing: role == null ? Icon(Icons.star) : Icon(Icons.paid),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => PaymentPage()));
            },
          ),
          ListTile(
            title: const Text('Change your password'),
            onTap: () async {
              //Navigator.pop(context);
              await showChangePw(context);
              //StatefulDialog();
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            trailing: Icon(Icons.logout),
            onTap: () async {
              // Update the state of the app
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('jwt');
              prefs.setBool('rememberMe', false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _oldPasswordVisible = false; //setta inizialmente la password oscurata
    _newPasswordVisible = false;
    super.initState();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showChangePw(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        obscureText: !_oldPasswordVisible,
                        onSaved: (newValue) => oldPassword = newValue,
                        onChanged: (value) {
                          setState(() {
                            oldPassword =
                                value; //switcha tra password oscurata e password visibile
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return mandatory;
                          }
                          if (errors.contains(invalidOldPw)) {
                            return "Invalid password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: BorderSide(color: kLightOrange),
                          ),

                          labelText: "Current Password",
                          //focusColor: kOrange,
                          hintText: "Enter your current password",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                            icon: Icon(
                              //cambia l'icona in base alla visibility della pw
                              _oldPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _oldPasswordVisible =
                                    !_oldPasswordVisible; //switcha tra password oscurata e password visibile
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        obscureText: !_newPasswordVisible,
                        onSaved: (newValue) => newPassword = newValue,
                        onChanged: (value) {
                          setState(() {
                            newPassword =
                                value; //switcha tra password oscurata e password visibile
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return mandatory;
                          }
                          if (errors.contains(invalidNewPw)) {
                            return "This password is too weak";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: BorderSide(color: kLightOrange),
                          ),

                          labelText: "New Password",
                          //focusColor: kOrange,
                          hintText: "Enter the new password",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                            icon: Icon(
                              //cambia l'icona in base alla visibility della pw
                              _newPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _newPasswordVisible =
                                    !_newPasswordVisible; //switcha tra password oscurata e password visibile
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              title: Text('Change your password'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () async {
                    String jwt = await changePassword();
                    //print(jwt);
                    //print(errors);
                    if (jwt.isNotEmpty) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('jwt', jwt);
                      Navigator.of(context).pop();
                    }
                    //chiamo la funzione validate per mostrare gli errori a schermo
                    if (!_formKey.currentState!.validate()) {
                      print("change password form not valid");
                    }
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
