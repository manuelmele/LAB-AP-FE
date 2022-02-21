import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/login/login_form.dart';
import 'package:wefix/size_config.dart';

class DialogsUI {
  showInfoDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showRatingDialog(BuildContext context, String name) {
    final _dialog = RatingDialog(
      initialRating: 5.0,
      // your app's name?
      title: Text(
        'Rate Service',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Add a review to $name',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      submitButtonText: 'Submit',
      commentHint: 'Leave Feedback',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  List<String?> errors = [];
  String? oldPassword;
  String? newPassword;
  bool _passwordVisible = false;
  showChangePasswordDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Change your password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          buildOldPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNewPasswordFormField(),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextFormField buildOldPasswordFormField() {
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
            //setState(() {
            _passwordVisible =
                !_passwordVisible; //switcha tra password oscurata e password visibile
            //});
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
            //setState(() {
            _passwordVisible =
                !_passwordVisible; //switcha tra password oscurata e password visibile
            //});
          },
        ),
      ),
    );
  }
}
