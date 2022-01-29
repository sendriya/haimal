import 'package:flutter/material.dart';
import 'package:haimal/components/default_button.dart';
import 'package:haimal/screens/home/home_screen.dart';
import 'package:haimal/screens/sign_in/sign_in_screen.dart';
import 'package:haimal/size_config.dart';

class Testing extends StatelessWidget {
  //const Testing({ Key? key }) : super(key: key);
static String routeName = "/testing";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Login Success"),
      ),
      body:Column(
      children: [
        //SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        //SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          //width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    ) 
      
    );
  }
}


