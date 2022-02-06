import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haimal/constants.dart';
import 'package:haimal/screens/complete_profile/complete_profile_screen.dart';
import 'package:haimal/server.dart';
import 'package:haimal/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_form.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  resendOtp() async {
    Loader.show(context,
        isSafeAreaOverlay: false,
        isAppbarOverlay: true,
        isBottomBarOverlay: true,
        progressIndicator: const CupertinoActivityIndicator(radius: 15),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
        overlayColor: const Color(0x99E8EAF6));
    String url = '$server/api/auth/users/resend_otp/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'JWT ' + token!,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      Loader.hide();
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Success'),
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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to +1 898 860 ***"),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  resendOtp();
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
