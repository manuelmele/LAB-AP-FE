import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/models/payment_model.dart';
import 'package:wefix/screens/login/login_form.dart';
import 'package:wefix/services/meetings_service.dart';
import 'package:wefix/services/review_service.dart';
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

  showRatingDialog(
      BuildContext context, String name, String _jwt, String emailReceive) {
    final _dialog = RatingDialog(
      initialRating: 5.0,
      title: const Text(
        'Rate Service',
        textAlign: TextAlign.center,
        style: TextStyle(
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

        addReview(
            _jwt, emailReceive, response.comment, response.rating.toInt());
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  showInfoPaymentDialog(
      BuildContext context,
      String title,
      String date,
      String deadline,
      double price,
      String currency,
      String paymentMethod,
      int id) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: kOrange,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Payment ID: ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                id.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: kGrey,
                ),
              ),
            ],
          ),
          Text(
            price.toString() + " " + currency,
            style: const TextStyle(
              fontSize: 40,
              color: kOrange,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          const Text(
            "Payed on:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            date.substring(0, 10),
            style: const TextStyle(
              fontSize: 20,
              color: kGrey,
            ),
          ),
          const Text(
            "Expiring on:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            deadline.substring(0, 10),
            style: const TextStyle(
              fontSize: 20,
              color: kGrey,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          const Text(
            "Payment Method:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            paymentMethod,
            style: const TextStyle(
              fontSize: 20,
              color: kGrey,
            ),
          ),
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
}
