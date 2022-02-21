import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/size_config.dart';

class StatefulDialog extends StatefulWidget {
  const StatefulDialog({Key? key}) : super(key: key);

  @override
  _StatefulDialogState createState() => _StatefulDialogState();
}

class _StatefulDialogState extends State<StatefulDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  String? oldPassword;
  String? newPassword;
  bool _passwordVisible = false;
  List<String?> errors = [];

  @override
  void initState() {
    _passwordVisible = false; //setta inizialmente la password oscurata
    //_loadUserEmailPassword();
    super.initState();
  }

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
                      buildOldPasswordFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildNewPasswordFormField(),
                    ],
                  )),
              title: Text('Stateful Dialog'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    //if (_formKey.currentState.validate()) {
                    // Do something like updating SharedPreferences or User Settings etc.
                    //Navigator.of(context).pop();
                    //}
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    print("inizio la build dell'alert");
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
              color: Colors.deepOrange,
              onPressed: () async {
                await showChangePw(context);
              },
              child: const Text(
                "Stateful Dialog",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    //print(_passwordVisible);
    return TextFormField(
      obscureText: !_passwordVisible,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        oldPassword = value;
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

        labelText: "Current Password",
        //focusColor: kOrange,
        hintText: "Enter your current password",
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
            print(_passwordVisible);
          },
        ),
      ),
    );
  }

  TextFormField buildNewPasswordFormField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        oldPassword = value;
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

        labelText: "New Password",
        //focusColor: kOrange,
        hintText: "Enter the new password",
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
}
