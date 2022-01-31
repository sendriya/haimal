import 'package:flutter/material.dart';
import 'package:haimal/size_config.dart';

import '../../../components/icon_with_background.dart';

class SiderBarItem extends StatelessWidget {
  const SiderBarItem({
    Key? key,
    this.onTap,
    required this.name,
    required this.iconData,
    required this.isActive,
  }) : super(key: key);

  final void Function()? onTap;
  final String name;
  final IconData iconData;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(5)),  //height:8.0
          child: Row(
            children: [
              IconWithBackground(iconData: iconData, size: getProportionateScreenWidth(18)),  //size: 18
              SizedBox(width: getProportionateScreenWidth(5)),  //width: 5
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
