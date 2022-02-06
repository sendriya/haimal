import 'package:flutter/material.dart';
import 'package:haimal/screens/home/components/categories.dart';
import 'package:haimal/screens/home/components/discount_banner.dart';
import 'package:haimal/screens/home/components/popular_product.dart';
import 'package:haimal/screens/home/components/special_offers.dart';
import 'package:haimal/size_config.dart';

import '../../constants/app_defaults.dart';
import 'components/home_header.dart';
import 'components/home_new_arrival_section.dart';
import 'components/search_bar.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/newhome";
  const HomePage({
    Key? key,
    this.backButton,
  }) : super(key: key);

  final Widget? backButton;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(backButton: backButton),
            const SizedBox(height: AppDefaults.margin / 2),
            DiscountBanner(),
            const SizedBox(height: AppDefaults.margin / 2),
            const SearchBar(),
            const SizedBox(height: AppDefaults.margin / 2),
            Categories(),
            const SizedBox(height: AppDefaults.margin / 2),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
