import 'package:flutter/material.dart';
import 'package:haimal/screens/sign_in/sign_in_screen.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.headingText,
    required this.image,
    required this.subText,
    required this.headingTextColor,
    required this.btnText,
    required this.subTextColor,
    required this.btnColor,
  }) : super(key: key);
  final String headingText, subText, image, btnText;

  final int headingTextColor, subTextColor, btnColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: FlatButton(
              padding: EdgeInsets.fromLTRB(0, 30, 30, 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Skip",
                    style: TextStyle(
                      fontSize: (17),
                      color: Color(0xFFF67952),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                      text: " >>>",
                      style: TextStyle(
                          fontSize: (16),
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.bold)),
                ]),
              )),
        ),
        const Spacer(),
        Text(
          headingText,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: Color(headingTextColor),
            // color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Text(
          subText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(subTextColor),
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        const Spacer(flex: 1),
        Image.network(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
