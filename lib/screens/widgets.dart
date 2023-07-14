// ignore_for_file: avoid_print, no_logic_in_create_state, must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel/screens/component.dart';
import 'package:hotel/screens/get_json.dart';

///---///

// move back page
Widget back(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
        hoverColor: Colors.blue.withOpacity(0),
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

// int id, String name, String categorie, double rate, int count, String img) {
//show product on screen

///---///

// show the item
Widget productCard(Product obj) {
  // int id, String name, String categorie, double rate, int count, String img) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: Center(
      child: ListTile(
        tileColor: Colors.grey[100],
        leading: Image.asset(
          obj.pImage,
          height: 200,
        ),
        title: textBold("\t  ${obj.pId}  ${obj.pName} ", 14),
        subtitle: Text("\t ${obj.pRate}"),
        // trailing: const AddCartButtons(),
        onTap: () {
          print(obj.pId.toString()); // like a index
        },
      ),
    ),
  );
}

// Card for Confirm
Widget itemCardConfirm(
    String id, String name, String rate, String categorie, File img) {
  return Container(
    height: 100,
    color: Colors.blue[100],
    child: Row(
      children: [
        Image.file(img),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(""),
            textBold("\t $id", 14),
            textBold("\t $name", 14),
            Text(
              "\t $categorie",
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              "\t $rate",
              style: const TextStyle(color: Colors.black),
            ),
          ],
        )
      ],
    ),
  );
}

// bold text with size
Widget textBold(String txt, double size) {
  return Text(
    txt,
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: size, color: Colors.black),
  );
}

// Next button
Widget nextButton(String txt, double w) {
  return Container(
    height: 50,
    width: w,
    margin: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
        color: Colors.blue[300], borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: Text(
        txt,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
    // child:
  );
}

// set the empty space
Widget gapSize(double w, double h) {
  return SizedBox(
    width: w,
    height: h,
  );
}

class ProductItemCard extends StatefulWidget {
  Product nobj;
  ProductItemCard({super.key, required this.nobj});

  @override
  State<ProductItemCard> createState() => _ProductItemCardState(nobj);
}

class _ProductItemCardState extends State<ProductItemCard> {
  Product nobj;

  _ProductItemCardState(this.nobj);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Center(
        child: ListTile(
          tileColor: Colors.grey[100],
          leading: Image.asset(
            // obj.pImage,
            nobj.pImage,
            height: 200,
          ),
          title: textBold("\t  ${nobj.pId}  ${nobj.pName} ", 14),
          subtitle: Text("\t ${nobj.pRate}"),
          trailing: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
//drop item
                // if (productslst[nobj.pId].getCount() != 0)
                IconButton(
                  onPressed: () {
                    // productslst[nobj.pId].decreaseItem();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                ),
//show qty
                // if (productslst[nobj.pId].getCount() != 0)
                // Text(
                //   (productslst[nobj.pId].pCartCount.toString()),
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
//add item
                IconButton(
                  onPressed: () {
                    // productslst[nobj.pId].increseItem();

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                ),
//show total price
                // if (productslst[nobj.pId].getCount() != 0)
                // Text(
                //   (productslst[nobj.pId - 1].getRate() *
                //           double.parse(
                //               productslst[nobj.pId].pCartCount.toString()))
                //       .toString(),
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          onTap: () {
            print(nobj.pId.toString()); // like a index
          },
        ),
      ),
    );
  }
}
// show the item




extension FirstCapitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}




