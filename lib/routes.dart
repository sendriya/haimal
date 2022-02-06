import 'package:flutter/widgets.dart';
import 'package:haimal/screens/approot/app_root.dart';
import 'package:haimal/screens/cart/cart_screen.dart';
import 'package:haimal/screens/complete_profile/complete_profile_screen.dart';
import 'package:haimal/screens/details/details_screen.dart';
import 'package:haimal/screens/forgot_password/forgot_password_screen.dart';
import 'package:haimal/screens/home/components/product_detail_screen.dart';
import 'package:haimal/screens/login_success/login_success_screen.dart';
import 'package:haimal/screens/home/home_page.dart';
import 'package:haimal/screens/onboarding/onboarding_page.dart';
import 'package:haimal/screens/otp/otp_screen.dart';
import 'package:haimal/screens/profile/profile_page.dart';
import 'package:haimal/screens/sign_in/sign_in_screen.dart';
import 'package:haimal/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnboardingPage.routeName: (context) => OnboardingPage(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfilePage.routeName: (context) => ProfilePage(),
  HomePage.routeName: (context) => HomePage(),
  AppRoot.routeName: (context) => AppRoot(),
  ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
};
