import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:haimal/components/custom_surfix_icon.dart';
import 'package:haimal/components/default_button.dart';
import 'package:haimal/components/form_error.dart';
import 'package:haimal/screens/complete_profile/complete_profile_screen.dart';
import 'package:haimal/screens/otp/otp_screen.dart';
import 'package:haimal/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/icon_with_background.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? phoneNumber;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error))
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  signUp(String email, password, mobile) async {
    Loader.show(context,
        isSafeAreaOverlay: false,
        isAppbarOverlay: true,
        isBottomBarOverlay: true,
        progressIndicator: const CupertinoActivityIndicator(radius: 15),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
        overlayColor: const Color(0x99E8EAF6));
    String url = '$server/api/auth/users/register_user/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': password, 'mobile': mobile};
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        Loader.hide();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => OtpScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      Loader.hide();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Error'),
              content: Text(json.decode(response.body)['detail']),
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                // Navigator.pushNamed(context, OtpScreen.routeName);
                signUp(emailController.text, passwordController.text,
                    phoneController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.lock),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.lock),
        labelText: "Password",
        hintText: "Enter your password",
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.message),
        labelText: 'Email',
        hintText: 'you@email.com',
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: IconWithBackground(iconData: IconlyBold.call),
        labelText: "Phone Number",
        hintText: "Enter your phone number",
      ),
    );
  }
}
