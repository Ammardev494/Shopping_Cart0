// ignore_for_file: avoid_print
import 'package:flutter/material.dart';


Color  cartButtonColor= Colors.green.shade500;
    

// cart info class
class CartInfo {
  int totalItems;
  double totalBill;
  //  int discount;
  CartInfo(this.totalItems, this.totalBill);
  void incresetotalItem() {
    totalItems++;
  }

  void decreasetotalItem() {
    if (totalItems > 0) totalItems--;
  }

  int getTotalItem() {
    return totalItems;
  }

void cartbillset(double rs){
  totalBill=rs;

}
void addBill(double rs){
  totalBill+=rs;
}
double getBill(){
  return totalBill;
}
}

CartInfo cartObj=CartInfo(0, 0);

// list of cart class
List<CartProduct> cartItemsList = [];

// cart item Object class
// product class haveing item count //  pId / pName / pCategory / pRate / pCartCount / pImage
class CartProduct {
  int pId;
  String? pName;
  String? pCategory;
  double pRate;
  bool inCart;
  int pCartCount;
  String? pImage;
  CartProduct(
    this.pId,
    this.pName,
    this.pCategory,
    this.pRate,
    this.inCart,
    this.pCartCount,
    this.pImage,
  );
  void increseItem() {
    pCartCount++;
  }

  decreaseItem() {
    if (pCartCount > 0) pCartCount--;
  }

  int getCount() {
    return pCartCount;
  }

  int getID() {
    return pId;
  }

  double getRate() {
    return pRate;
  }

  getData() {
    print(
        "\n\nID:   $pId\nName: ${pName!}\nCat:  ${pCategory!}\nRs:   $pRate\nQty:  $pCartCount\nImg:  ${pImage!}");
  }
}







