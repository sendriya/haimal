import 'package:flutter/material.dart';
import 'package:haimal/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(),
    );
  }
}
