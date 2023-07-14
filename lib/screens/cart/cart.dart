// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/screens/cart/cart_widgets.dart';
import 'package:hotel/screens/cart/components.dart';
import 'package:hotel/screens/get_json.dart';
import 'package:hotel/screens/widgets.dart';
import 'package:badges/badges.dart' as badges;

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Text(
                cartObj.getTotalItem().toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    Get.to(() => const Cart());
                  });
                },
                icon: const Icon(
                  Icons.shopping_cart_checkout_rounded,
                ),
              ),
            ),
          ),
          gapSize(20, 0)
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          gapSize(0, 10),
          if (cartItemsList.isNotEmpty) tBill(),
          gapSize(0, 10),
          // added item show
          cartItemsList.isNotEmpty
              ? cartProducts()
              : Center(
                  child: Column(children: [
                  const Text("Cart is Empty"),
                  gapSize(0, 30),
                  Image.asset(
                    'assets/images/cartempty.png',
                  )
                ])),
        ]),
      ),
    );
  }

// it show the list of products in cart if not empty
  Widget cartProducts() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cartItemsList.length,
        itemBuilder: (context, index) {
          return CartItemTile(index);
        });
  }

// it take a index and show on screen
  Widget CartItemTile(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(width: 1, color: cartButtonColor)),
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(5),
      child: Row(children: [
        Image.asset(
          cartItemsList[index].pImage.toString(),
          width: 120,
        ),
        gapSize(10, 0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // textBold("${cartItemsList[index].pName}", 14),
              textBold(
                  FirstCapitalize('${cartItemsList[index].pName}').capitalize(),
                  14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${cartItemsList[index].pRate}"),
                  // delete item in cart
                  IconButton(
                      onPressed: () {
                        productslst[cartItemsList[index].pId - 1].inCart =
                            false;
                        productslst[cartItemsList[index].pId].pId;
                        cartItemsList.removeAt(index);
                        cartObj.decreasetotalItem();
                        setState(() {});
                        print("Delete ${cartItemsList[index].pName}");
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddCartButtons(index),
                  Text(
                      '${cartItemsList[index].pCartCount * cartItemsList[index].pRate} '),
                ],
              ),
            ],
          ),
        ),
        gapSize(10, 0)
      ]),
    );
  }

// show the bill
  Widget tBill() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 360,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          textBold("Bill", 16),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Total Bill: "),
            textBold("${getTotal()}", 14)
          ]),
        ],
      ),
    );
  }

  double getTotal() {
    cartObj.cartbillset(0);
    // double totalbill = 0;
    for (int i = 0; i < cartItemsList.length; i++) {
      // totalbill += cartItemsList[i].pRate *
      double.parse(cartItemsList[i].pCartCount.toString());
      cartObj.addBill(cartItemsList[i].pRate *
          double.parse(cartItemsList[i].pCartCount.toString()));
      setState(() {});
    }

    setState(() {});
    // return totalbill;
    return cartObj.getBill();
  }
}
