import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/payment_model.dart';

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
  List<PaymentModel> paymentsData = [];

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
          print(paymentsData);
        });
      });
    });
  }

  Widget build(BuildContext context) {
    getPaymentsData();
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(30),
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/parrot_contrast.jpg',
                height: 70,
                width: 70,
              ),
              const SizedBox(height: 1),
              Text(
                "Your payment history",
                style: TextStyle(
                  color: kOrange,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Text(
                "Manage your payments and subscription",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenWidth(60)),
              Scaffold(
                  body: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
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
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              )),
              Container(
                //box with image and text
                child: SubscriptionContent(
                  state: "State: " + "Active",
                  plan: "Monthly Plan",
                  cost: "5/month",
                  expiration: "Expiration date: " + "21/03/22",
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kLightOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Renew Subscription'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => PaymentPage()));
                    }),
              ),
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
        contentPadding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text(
          date,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
