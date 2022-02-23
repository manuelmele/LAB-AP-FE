import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/payment_model.dart';
import 'package:wefix/screens/navigator/navigator.dart';

import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/services/worker_services.dart';
import 'subscription_content.dart';

import 'package:wefix/size_config.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int currentPage = 0;
  var today = DateTime.now();
  //List<PaymentModel> paymentsData = [];
  List<PaymentModel> paymentsData = [
    PaymentModel(
        paymentId: "1",
        date: "23/12/2021",
        deadline: "23/01/2022",
        price: "0.80",
        currency: "EUR",
        paymentMethod: "PayPal"),
    PaymentModel(
        paymentId: "2",
        date: "23/01/2022",
        deadline: "23/02/2022",
        price: "0.80",
        currency: "EUR",
        paymentMethod: "PayPal"),
  ];

  //pageController lets us choose which page of the pageviwe to see
  final PageController _pageController = PageController();
  @override //non so a che serve l'ho preso dalle api di flutter
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> getPaymentsData() async {
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;

      getPaymentsDataService(jwt).then((newResults) {
        setState(() {
          paymentsData = newResults;
          //print(paymentsData);
        });
      });
    });
  }

  Widget build(BuildContext context) {
    //getPaymentsData();

    if (paymentsData.isEmpty) {
      //print("non ci sono pagamenti");
      return buildNoPayments();
    } else {
      print("ci sono dei pagamenti");
      return Scaffold(
        backgroundColor: kBackground,
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08), // 4%
                Image.asset(
                  'assets/images/parrot_contrast.jpg',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 0.04),
                Text(
                  "Your payment history",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "Manage your payments and subscription",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: paymentsData.length,
                  itemBuilder: (context, i) {
                    return ListPayment(
                      paymentId: paymentsData[i].paymentId,
                      date: paymentsData[i].date,
                      deadline: paymentsData[i].deadline,
                      price: paymentsData[i].price,
                      currency: paymentsData[i].currency,
                      paymentMethod: paymentsData[i].paymentMethod,
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildNoPayments() {
    return Scaffold(
      backgroundColor: kBackground,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              Image.asset(
                'assets/images/parrot_contrast.jpg',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 0.04),
              Text(
                "Your payment history",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kOrange,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "There are no payments in your history",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kLightOrange,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, NavigatorScreen.routeName);
                  },
                  child: const Text("Go Back"))
            ],
          ),
        ),
      ),
    );
  }
}

class ListPayment extends StatelessWidget {
  const ListPayment({
    Key? key,
    required this.paymentId,
    required this.date,
    required this.deadline,
    required this.price,
    required this.currency,
    required this.paymentMethod,
  }) : super(key: key);

  final String paymentId;
  final String date;
  final String deadline;
  final String price;
  final String currency;
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[200];
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[200],
      ),
      child: ListTile(
        leading: Icon(
          Icons.circle,
          color: DateTime.now().isBefore(DateFormat("dd/MM/yyyy HH:mm:ss")
                  .parse(deadline + " 00:00:00"))
              ? kLightGreen
              : kGrey,
        ),
        contentPadding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text(
          date,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          price + " " + currency,
          style: const TextStyle(
            fontSize: 30,
            color: kOrange,
          ),
        ),
      ),
    );
  }
}
