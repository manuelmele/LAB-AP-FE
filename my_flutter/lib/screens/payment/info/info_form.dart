import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/services/auth_service.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/payment/summary/summary.dart';
import 'package:flutter/src/material/dropdown.dart';



//import 'package:form_field_validator/form_field_validator.dart';
//import 'package:shop_app/components/custom_surfix_icon.dart';
//import 'package:shop_app/components/form_error.dart';
//import 'package:shop_app/helper/keyboard.dart';
//import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
//import 'package:shop_app/screens/login_success/login_success_screen.dart';

import '../../../size_config.dart';

class InfoForm extends StatefulWidget {
  @override
  _InfoFormState createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _alertKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? jwt;
  String? partita_iva;

  String? _myActivity;
  String? _myActivityResult;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  List dataSource = [
    {
      "display": "Running",
      "value": "Running",
    },
    {
      "display": "Climbing",
      "value": "Climbing",
    },
    {
      "display": "Walking",
      "value": "Walking",
    },
    {
      "display": "Swimming",
      "value": "Swimming",
    },
    {
      "display": "Soccer Practice",
      "value": "Soccer Practice",
    },
    {
      "display": "Baseball Practice",
      "value": "Baseball Practice",
    },
    {
      "display": "Football Practice",
      "value": "Football Practice",
    },
  ];


  bool _passwordVisible = false; //makes the password readable or dotted
  //note the underscore in front of the variable name means that the variable is private to this file

  //funzione che verifica le credenziali
  Future<String> Info() async {
    errors = [];
    //prima di tutto controllo se i campi sono stati lasciati vuoti
    if (email == null || email == "" || password == null || password == "" || partita_iva == null || partita_iva == "" ) {
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

     _myActivity = '';
    _myActivityResult = '';
    focusNode.addListener(() {
      focusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
    });
  }


  List<String?> errors = [];

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
String dropdownValue = 'Plumber';
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
          buildPIvaFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kLightOrange,
              ),
              child: const Text('Continue'),
              onPressed: () async {
                //chiama la funzione signin per verificare le credenziali
                //signin ritorna "" se c'è qualche problema
                String jwt = await Info();
                print(jwt);
                if (jwt.isNotEmpty) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setString('jwt', jwt);
                  prefs.setString('email', email!);
                  Navigator.pushNamed(
                      context, SummaryPage.routeName);
                }
                //chiamo la funzione validate per mostrare gli errori a schermo
                if (!_formKey.currentState!.validate()) {
                  print("login form not valid");
                }
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
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

 /* DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Plumber', 'Tiler', 'Electrician', 'Glazier', 'Gardener', 'Carpenter']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(), */



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



  TextFormField buildPIvaFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => partita_iva = newValue,
      onChanged: (value) {
        partita_iva = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(wrong)) {
          return "Invalid email, password or partita iva";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Partita iva",
        hintText: "Enter your partita iva",

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
