import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:haimal/api/ProductsAPI.dart';
import 'package:haimal/components/product_card.dart';
import 'package:haimal/models/Products.dart';
import 'package:haimal/screens/home/components/product_detail_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<Products>> futureData;

  @override
  void initState() {
    super.initState();
    // Loader.show(context, progressIndicator: LinearProgressIndicator());
    futureData = fetchProducts();
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Products>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Loader.hide();
            List<Products>? data = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SectionTitle(
                    title: "Popular Products",
                    press: () {},
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        ...List.generate(
                          data!.length,
                          (index) {
                            if (data[index].isPopular) {
                              return ProductCard(
                                productName: data[index].name,
                                image: data[index].imageUrl[0],
                                description: data[index].description,
                                price: data[index].price,
                                quantity: data[index].quantity,
                                quantityType: data[index].quantityType,
                                hasPlan: data[index].hasPlan,
                                press: () => {
                                  Navigator.pushNamed(
                                      context, ProductDetailsScreen.routeName,
                                      arguments: ProductDetailsArguments(
                                        productName: data[index].name,
                                        image: data[index].imageUrl,
                                        description: data[index].description,
                                        price: data[index].price,
                                        quantity: data[index].quantity,
                                        hasPlan: data[index].hasPlan,
                                      ))
                                },
                              );
                            }

                            return SizedBox
                                .shrink(); // here by default width and height is 0
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Loader.hide();
            return Text("${snapshot.error}");
          } else {
            Loader.show(context,
                isSafeAreaOverlay: false,
                isAppbarOverlay: true,
                isBottomBarOverlay: true,
                progressIndicator: const CupertinoActivityIndicator(radius: 15),
                themeData: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: Colors.black38)),
                overlayColor: const Color(0x99E8EAF6));
            return Container();
          }
        },
      ),
    );
  }
}
