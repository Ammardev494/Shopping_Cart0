// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/screens/add_product.dart';
import 'package:hotel/screens/api_services.dart';
import 'package:hotel/screens/cart/cart.dart';
import 'package:hotel/screens/cart/components.dart';
import 'package:hotel/screens/product_info.dart';
import 'package:hotel/screens/widgets.dart';
// import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;

class GetJsonData extends StatefulWidget {
  const GetJsonData({super.key});

  @override
  State<GetJsonData> createState() => _GetJsonDataState();
}

// ignore_for_file: avoid_print

///product class
//  pId / pName / pCategory / pRate / pCartCount / pImage
class Product {
  int pId;
  String pName;
  String pCategory;
  double pRate;
  bool inCart;
  String pImage;
  Product(
    this.pId,
    this.pName,
    this.pCategory,
    this.pRate,
    this.inCart,
    this.pImage,
  );

  bool getinCart() {
    return inCart;
  }

  int getID() {
    return pId;
  }

  double getRate() {
    return pRate;
  }

  getData() {
    print(
        "\n\nID:   $pId\nName: $pName\nCat:  $pCategory\nRs:   $pRate\ninCart:  $inCart\nImg:  $pImage");
  }
}

//list to store the Api products as a object
List<Product> productslst = [
  // Product('11', '00', '11', '00', '11'),
];

class _GetJsonDataState extends State<GetJsonData> {
// search products
  List<Product> searchResults = [];
  void searchProducts(String query) {
    setState(() {
      searchResults = productslst
          .where((product) =>
              product.pName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('API Data'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                productslst.clear();
                getproducts();
                searchResults.clear();
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
          Center(
            child: badges.Badge(
              badgeContent: Text(
                cartObj.getTotalItem().toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => const Cart());
                  },
                  icon: const Icon(Icons.shopping_cart_rounded)),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(const AddItem());
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          // search field
          Container(
            padding: const EdgeInsets.all(3),
            height: 40,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: searchProducts,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                prefix: Icon(Icons.search),
              ),
            ),
          ),
          if (searchResults.isNotEmpty) Text(searchResults.length.toString()),

          // show the search results
          if (searchResults.isNotEmpty)
            ListView.builder(
                shrinkWrap: true,
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var obj = Product(
                      searchResults[index].pId,
                      searchResults[index].pName,
                      searchResults[index].pCategory,
                      searchResults[index].pRate,
                      false,
                      'assets/images/default_img.png');
                  // return productCard(obj);
                  return showProduct(obj.pId - 1);
                }),

          if (productslst.isNotEmpty && searchResults.isEmpty)
            const Text('Available Products'),

          // show the available products in Api
          if (productslst.isNotEmpty && searchResults.isEmpty)
            productslst.isNotEmpty == true ? showproductscard() : loader(),
        ]),
      ),
    );
  }

//to get the json data
  List<dynamic>? allProducts;
  getproducts() async {
    //store api data in list
    var allProducts = await getApiData();
    // print(allProducts); // see all received data
    setState(() {});
// push the api data in list
    for (int i = 0; i < 60; i++) {
// get the list element in object
      var obj = Product(
        int.parse(allProducts['data'][i]['product_id']),
        allProducts['data'][i]['product_name'].toString(),
        allProducts['data'][i]['categories_name'].toString(),
        double.parse(allProducts['data'][i]['rate']),
        false, // set false because not in cart
        'assets/images/default_img.png',
      );
// push object in a list
      productslst.add(obj);
    }
  }

// show products in console
  getProducts() {
// productslst
    if (productslst.isEmpty) {
      print("List is empty");
    } else {
      print("${productslst.length} Items available");
      // Get data using loop
      for (var i = 0; i < productslst.length; i++) {
        // ignore: prefer_interpolation_to_compose_strings
        print('\nproduct$i:\n' + productslst[i].getData());
      }
    }
  }

// it show the list of products that available
  Widget showproductscard() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: productslst.length,
        itemBuilder: (context, index) {
          return showProduct(index);
        });
  }

// show loading
  loader() {
    setState(() {});
    return const CircularProgressIndicator();
  }

  Widget showProduct(int index) {
    String cartStatus = 'Add to cart';
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(2),
      height: 100,
      color: Colors.grey[100],
      child: Row(children: [
        InkWell(
          onTap: () {
            Product obj = Product(
              productslst[index].pId, // pId,
              productslst[index].pName,
              // pName,
              productslst[index].pCategory,
              //  pCategory,
              productslst[index].pRate,
              //   pRate,
              productslst[index].inCart,
              //    inCart,
              productslst[index].pImage,
              //     pImage
            );
            Get.to(ProductInfo(obj));
          },
          child: Image.asset(
            productslst[index].pImage,
          ),
        ),
        gapSize(10, 0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textBold(
                  "  ${FirstCapitalize(productslst[index].pName).capitalize()} ",
                  14),
              Text("\t ${productslst[index].pRate}"),
              TextButton(
                  onPressed: () {
                    String msg;
                    //add to cartItemsList
                    if (productslst[index].inCart != true) {
                      cartItemsList.add(CartProduct(
                          productslst[index].pId,
                          productslst[index].pName,
                          productslst[index].pCategory,
                          productslst[index].pRate,
                          productslst[index].inCart,
                          1,
                          productslst[index].pImage));
                      productslst[index].inCart = true;
                      cartObj.incresetotalItem();
                      msg = "Added";
                    } else {
                      msg = "Allready Added";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(msg),
                        // backgroundColor: Colors.blue[100],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(cartButtonColor),
                  ),
                  child: Text(
                    cartStatus,
                    // "Add to cart",
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
