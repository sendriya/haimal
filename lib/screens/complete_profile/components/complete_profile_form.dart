import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:haimal/components/custom_surfix_icon.dart';
import 'package:haimal/components/default_button.dart';
import 'package:haimal/components/form_error.dart';
import 'package:haimal/components/icon_with_background.dart';
import 'package:haimal/screens/home/home_screen.dart';
import 'package:haimal/screens/otp/otp_screen.dart';
import 'package:haimal/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? selectedSalutation;

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

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

  completeProfile(String name, address1, address2) async {
    Loader.show(context,
        isSafeAreaOverlay: false,
        isAppbarOverlay: true,
        isBottomBarOverlay: true,
        progressIndicator: const CupertinoActivityIndicator(radius: 15),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
        overlayColor: const Color(0x99E8EAF6));
    String url = '$server/api/auth/address/add/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'name': name,
      'addressLine1': address1,
      'addressLine2': address2
    };
    var token = sharedPreferences.getString('token');

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'JWT ' + token!,
          'Content-Type': 'application/json',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      Loader.hide();
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      Loader.hide();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Error'),
              content: const Text('Something went wrong, Please try again'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          locationDropDown(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddress1FormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddress2FormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                completeProfile(nameController.text, address1Controller.text,
                    address2Controller.text);
                // Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddress1FormField() {
    return TextFormField(
        controller: address1Controller,
        onSaved: (newValue) => address = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          prefixIcon: IconWithBackground(iconData: IconlyBold.location),
          labelText: "Address Line1",
          hintText: "Enter your address",
        ),
        maxLength: 200);
  }

  TextFormField buildAddress2FormField() {
    return TextFormField(
        controller: address2Controller,
        onSaved: (newValue) => lastName = newValue,
        decoration: const InputDecoration(
          prefixIcon: IconWithBackground(iconData: IconlyBold.location),
          labelText: "Address Line2",
          hintText: "Enter your address",
        ),
        maxLength: 200);
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: nameController,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.profile),
        labelText: "Full Name",
        hintText: "Enter your full name",
      ),
      maxLength: 25,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExp("[a-zA-ZÄäÖöÜü]")) //Only Text as input
      ],
    );
  }

  DropdownButtonFormField<String> locationDropDown() {
    return DropdownButtonFormField<String>(
      onSaved: (newValue) => selectedSalutation = newValue,
      decoration: const InputDecoration(
          prefixIcon: IconWithBackground(iconData: IconlyBold.location),
          hintText: 'Location'),
      onChanged: (salutation) {
        removeError(error: kLocationNullError);
        setState(() => selectedSalutation = salutation);

        return null;
      },
      validator: (value) {
        if (value == null) {
          addError(error: kLocationNullError);
          return "";
        }
        return null;
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
