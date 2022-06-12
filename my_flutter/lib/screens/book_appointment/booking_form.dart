import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/main.dart';
import 'package:wefix/screens/book_appointment/confirmation.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/services/auth_service.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'package:wefix/services/user_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BookingForm extends StatefulWidget {
  final String emailWorker;

  const BookingForm({Key? key, required this.emailWorker}) : super(key: key);
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String? description;
  String? timeSlot;
  List<String> timeSlots = ["Morning", "Afternoon", "Evening"];
  List<String?> errors = [];
  var today;
  var minDate;
  var maxDate;
  String? _chosenDate;
  String? _chosenTime;

  Future<String> bookAppointment(_emailWorker) async {
    if (_chosenDate == null) {
      return "Error: date field is required";
    }
    errors = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _emailCustomer = prefs.getString('email');
    String? _jwt = prefs.getString('jwt');
    //PRENDERE EMAIL DEL WORKER QUANDO SARÀ PRONTA LA PAGINA UTENTE WORKER
    //String? _emailWorker = "marcopinorossi@live.it";

    String response = await bookAppointmentService(_emailWorker,
        _emailCustomer!, _chosenDate!, _chosenTime!, description!, _jwt!);

    if (response.contains('Error')) {
      String error = response;
      //addError(error: error);
      return error;
    }
    return '';
    //print(response);
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

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    minDate = DateTime(today.year, today.month, today.day + 1);
    maxDate = DateTime(today.year, today.month, today.day + 15);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildDateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTimeSlotFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProblemDescriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kLightOrange,
            ),
            child: const Text('Continue'),
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                print("booking form not valid");
              } else {
                //MODIFICARE QUI PER RENDERE CAMPO DINAMICO
                String? emailWorker = widget.emailWorker;
                String res = await bookAppointment(emailWorker);
                //METTERE res=="" QUANDO LO TESTI DAVVERO
                if (res == "") {
                  Navigator.pushReplacementNamed(
                      context, BookingConfirmationScreen.routeName);
                } else {
                  print(res);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  FormField buildDateFormField() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: BorderSide(color: kLightOrange),
            ),
            labelText: "Time Slot",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),

          //isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is DateTime) {
                    _chosenDate = DateFormat("dd/MM/yyyy").format(args.value);
                    print(_chosenDate);
                  }
                },
                allowViewNavigation: false,
                minDate: minDate,
                maxDate: maxDate,
                view: DateRangePickerView.month,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1)),
          ),
        );
      },
    );
  }

  DropdownButtonHideUnderline buildTimeSlotFormField() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return mandatory;
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: kLightOrange),
          ),
          labelText: "Time Slot",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        hint: Text("Select the time slot you prefer"),
        value: _chosenTime,
        isDense: true,
        onChanged: (newValue) {
          setState(() {
            _chosenTime = newValue;
          });
          print(_chosenTime);
        },
        items: timeSlots.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  TextFormField buildProblemDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      onSaved: (newValue) => description = newValue,
      onChanged: (value) {
        description = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        if (errors.contains(wrong)) {
          return "Invalid field";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Problem Description",
        hintText: "Describe the problem you need to be solved",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
