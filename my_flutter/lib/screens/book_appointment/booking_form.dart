import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/main.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/services/auth_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String? description;
  String? timeSlot;
  String? _currentSelectedValue;
  List<String> timeSlots = ["morning", "afternoon"];
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTimeSlotFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProblemDescriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kLightOrange,
            ),
            child: const Text('Continue'),
            onPressed: () async {},
          ),
        ],
      ),
    );
  }

  FormField buildTimeSlotFormField() {
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
            child: DropdownButton<String>(
              hint: Text("Select the time slot you prefer"),
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  _currentSelectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: timeSlots.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
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
