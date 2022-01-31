import 'package:flutter/material.dart';
import 'package:haimal/api/OnBoardingAPI.dart';
import 'package:haimal/models/OnBoarding.dart';
import 'package:haimal/screens/sign_in/sign_in_screen.dart';
import 'package:haimal/screens/splash/components/splash_content.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<OnBoarding>> futureData;
  int currentPage = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    futureData = fetchScreens();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: FutureBuilder<List<OnBoarding>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OnBoarding>? data = snapshot.data;
              return SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: PageView.builder(
                          controller: _controller,
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          itemCount: data!.length,
                          itemBuilder: (context, index) => SplashContent(
                            headingText: data[index].headingText,
                            subText: data[index].subText,
                            btnText: data[index].btnText,
                            image: data[index].imageUrl,
                            headingTextColor: data[index].headingTextColor,
                            btnColor: data[index].btnColor,
                            subTextColor: data[index].subTextColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Column(
                            children: <Widget>[
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  data.length,
                                  (index) => buildDot(index: index),
                                ),
                              ),
                              const Spacer(flex: 2),
                              DefaultButton(
                                text: (currentPage == data.length - 1
                                    ? "Get Started"
                                    : "Next"),
                                press: () {
                                  if (currentPage == data.length - 1) {
                                    Navigator.pushNamed(
                                        context, SignInScreen.routeName);
                                  } else {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Loading, Please Wait...',
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
