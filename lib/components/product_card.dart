import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 150,
    this.aspectRation = 1.02,
    required this.productName,
    required this.image,
    required this.price,
    required this.description,
    required this.quantity,
    required this.quantityType,
    required this.press,
    required this.hasPlan,
  }) : super(key: key);

  final double width, aspectRation;
  final String productName, image, price, description, quantityType;
  final int quantity;
  final GestureTapCallback press;
  final bool hasPlan;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: widget.press,
        child: SizedBox(
          width: getProportionateScreenWidth(widget.width),
          //height: getProportionateScreenHeight(300),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(15)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AspectRatio(
                aspectRatio: widget.aspectRation,
                child: Container(
                  decoration: BoxDecoration(
                    //color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.image),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                widget.productName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(16)),
                maxLines: 2,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                "${widget.quantity} ${widget.quantityType}",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                "₹${widget.price}",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
