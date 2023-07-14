// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:hotel/screens/cart/components.dart';

class AddCartButtons extends StatefulWidget {
  int index;
  AddCartButtons(this.index, {super.key});
  @override
  State<AddCartButtons> createState() => _AddCartButtonsState(index);
}

class _AddCartButtonsState extends State<AddCartButtons> {
  int index; //card list index
  int totalRs = 0;
  _AddCartButtonsState(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: cartButtonColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (cartItemsList[index].getCount() != 0)
            //decerese item
            IconButton(
              onPressed: () {
                setState(() {
                  if (cartItemsList[index].getCount() > 1) {
                    cartItemsList[index].decreaseItem();
                  }
                });
              },
              icon: const Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.white,
              ),
            ),
          if (cartItemsList[index].getCount() != 0)
            Text(
              cartItemsList[index].getCount().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          //incerese item
          IconButton(
            onPressed: () {
              setState(() {
                cartItemsList[index].increseItem();
              });
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
