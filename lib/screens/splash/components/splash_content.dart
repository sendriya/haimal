import 'package:flutter/material.dart';

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
