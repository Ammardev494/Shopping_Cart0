import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/screens/get_json.dart';
import 'package:hotel/screens/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hotel'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapSize(0, 20),
              FloatingActionButton(
                onPressed: () {
                  Get.to(()=> const GetJsonData());
                },
                child: const Icon(Icons.store),
              ),
              gapSize(0, 20),
            ],
          ),
        ));
  }
}



