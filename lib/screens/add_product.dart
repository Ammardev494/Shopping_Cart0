// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:hotel/screens/component.dart';
import 'package:hotel/screens/get_json.dart';
import 'package:hotel/screens/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddItem extends StatefulWidget {
  const AddItem({super.key});
  @override
  State<AddItem> createState() => _AddItemState();
}

File? itemImage;

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  //Categorie List
  List<String> itemCategorieLst = [
    "Select Categorie",
    "Beef Karahi",
    "Chicken Karahi",
    "Chicken Handi",
    "Daal+Sabzi",
    "Mutton Karahi",
    "Raita+Salad",
    "Refreshment",
    "Sabzi",
    "Special Bar B.Q",
    "Special Fish",
    "Special Plao",
    "Other",
  ];

  String iCategorie = "Select Categorie";
  var productImage = itemImage;
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController rateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: enterData(),
    );
  }

// add item view
  Widget enterData() {
    return Center(
      child: Container(
        height: 500,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              back(context),
              // Add item box
              textBold("Add Item", 20),
              const Text("Fill The Data Below"),
              const Divider(),
              // image box
              InkWell(
                onTap: () {
                  seletPicker();
                },
                child: Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: itemImage == null
                      ? Image.asset('assets/images/default_img.png')
                      : Image.file(itemImage!),
                ),
              ),

              ///
              // productName;
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: productNameCtrl,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    border: InputBorder.none,
                    // label: Text("Name"),
                    hintText: "Item",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Product name is required';
                    }
                    return null;
                  },
                ),
              ),
              // categoriesName;
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // categoriesLst
                  child: DropdownButton(
                      underline: const SizedBox(),
                      value: iCategorie,
                      items: itemCategorieLst.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                            ));
                      }).toList(),
                      onChanged: (String? value) {
                        iCategorie = value.toString();
                        setState(() {});
                      }),
                ),
              ),

// rate;
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: rateCtrl,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      border: InputBorder.none,
                      // label: Text("Rate"),
                      hintText: "0.00"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Price is required';
                    }
                    // Validate if the input is a valid number
                    if (double.tryParse(value) == null) {
                      return 'Invalid price value';
                    }
                    return null;
                  },
                ),
              ),
// next
              InkWell(
                onTap: () {
                  itemImage ??= File('assets/images/default_img.png');
                  _submitForm();
                },
                child: nextButton("Add", 300),
              ),
            ]),
          ),
        ),
      ),
    );
  }

//getting image from device
  seletPicker() async {
    ImagePicker imagePicker = ImagePicker();
    var selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (selectedImage != null) {
        itemImage = File(selectedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

// status item view
  Widget confirmData() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
// Successful label
            const Text(
              "Successful",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const Divider(),
// productCard(),
            itemCardConfirm('id', productNameCtrl.text.toString(),
                rateCtrl.text, iCategorie, itemImage!),
          ]),
        ),
      ),
    );
  }

  ///--///
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showvalues();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: confirmData(),
          backgroundColor: Colors.blue[100],
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        print("Refresh");
        reset();
      });
    }
  }

// reset the values
  reset() {
    setState(() {
      // print("Reset");
      itemImage = null;
      iCategorie = "Select Categorie";
      // productImage = null;
      productNameCtrl.clear();
      rateCtrl.clear();
    });
  }

// show the hard values
  showvalues() {
    var newProduct = Product(
      101,
      productNameCtrl.text,
      iCategorie,
      double.parse(rateCtrl.text),
      false,
      '$itemImage',
    );
    print(productImage);
    print("Obj Data is");
    newProduct.getData();
// push here

// add a new product in your record
    setState(() {});
  }
}
