import 'package:flutter/material.dart';
import 'package:hotel/screens/component.dart';
import 'package:hotel/screens/get_json.dart';
import 'package:hotel/screens/widgets.dart';

// ignore: must_be_immutable
class ProductInfo extends StatelessWidget {
  Product obj;
  ProductInfo(this.obj, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        gapSize(0, 40),
        back(context),
        gapSize(0, 100),
        // Text("id: ${obj.pId}"),
        Image.asset(obj.pImage.toString()),
        textBold(' ${FirstCapitalize(obj.pName).capitalize()}', 14),
        Text(obj.pCategory),
        Text(obj.pRate.toString()),
      ]),
    );
  }
}
  
