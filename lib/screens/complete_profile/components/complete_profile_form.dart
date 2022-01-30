import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:haimal/components/custom_surfix_icon.dart';
import 'package:haimal/components/default_button.dart';
import 'package:haimal/components/form_error.dart';
import 'package:haimal/components/icon_with_background.dart';
import 'package:haimal/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
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
  
  final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
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
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddress1FormField() {
    return TextFormField(
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
      decoration: InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.location),
        labelText: "Address Line1",
        hintText: "Enter your address",
      ),
      maxLength: 200
    );
  }


  TextFormField buildAddress2FormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.location),
        labelText: "Address Line2",
        hintText: "Enter your address",
      ),
      maxLength: 200
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
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
      decoration: InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.profile),
        labelText: "Full Name",
        hintText: "Enter your full name",
      ),
      maxLength: 25,
      inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-ZÄäÖöÜü]")) //Only Text as input
                  ],
    );
  }

    DropdownButtonFormField<String> locationDropDown() {
    return DropdownButtonFormField<String>(
            onSaved: (newValue) => selectedSalutation = newValue,
            
            decoration: InputDecoration(
              prefixIcon: IconWithBackground(iconData: IconlyBold.location),
              hintText: 'Location'
            ),
            
            onChanged: (salutation){
                removeError(error: kLocationNullError);
                setState(() => selectedSalutation = salutation);
                
                return null;
            },
            validator: (value){
              if (value == null) {
          addError(error: kLocationNullError);
          return "";
        }
        return null;
            },
            items:
                items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
  }

}
