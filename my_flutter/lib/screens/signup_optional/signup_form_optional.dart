import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/main.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpFormOptional extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpFormOptional> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? surname;
  String? email;
  String? password;
  String? bio;
  bool remember = false;
  List<String?> errors = [];

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<String> completeSignUp() async {
    errors = [];
    //per ora se l'utente lascia qualche campo vuoto la sua richiesta viene ignorata
    //vedere con mario come gestire meglio questa situazione
    //if (_imageFile == null || bio == null || bio == "") {
    //print("se non metti foto e bio non faccio nulla");
    //return "";
    //}

    String response = await completeSignUpService(bio, _imageFile, jwt!);

    if (response.contains('Error')) {
      String error = response;
      addError(error: error);
    } else {
      return jwt!;
    }
    return '';
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          imageProfile(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            child: errors.contains(imageTooBig)
                ? Text("Image should have maximum size 30KB",
                    style: TextStyle(color: kRed))
                : null,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBioField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kLightOrange,
            ),
            child: const Text('Continue'),
            onPressed: () async {
              print("provo a recuperare i dati dell'utente");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              print(prefs.getString('jwt'));
              jwt = prefs.getString('jwt');
              String response = await completeSignUp();
              print(response);
              if (response.isNotEmpty) {
                Navigator.pushNamed(context, NavigatorScreen.routeName);
              }
              print(errors);
              if (!_formKey.currentState!.validate()) {
                //_formKey.currentState!.save();
                print("sign up optional form not valid");
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildBioField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      //minLines: 1, //Normal textInputField will be displayed
      maxLines: 5,
      onSaved: (newValue) => bio = newValue,
      onChanged: (value) {
        bio = value;
      },
      validator: (value) {
        if (errors.contains(invalidBio)) {
          return "Invalid Bio";
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Tell something about yourself",
        hintText: "Write here...",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context, builder: ((builder) => bottomSheet()));
          },
          child: CircleAvatar(
            backgroundImage: _imageFile == null
                ? const AssetImage("assets/images/profile.jpeg")
                : Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                  ).image,
            radius: 80.0,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: kOrange,
              size: 38.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera, color: kOrange),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image, color: kOrange),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
