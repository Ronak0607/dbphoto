import 'dart:typed_data';

import 'package:dbphoto/Screen/dbHelper.dart';
import 'package:dbphoto/Screen/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Obx(
            () => ElevatedButton(
                onPressed: () async {
                  ByteData byteData =
                      await rootBundle.load("assets/Image/11.jpg");
                  Uint8List unitlist = byteData.buffer.asUint8List();

                  DbHelper db = DbHelper();
                  db.insertData("ronak", "9737987808", unitlist);
                },
                child: Icon(Icons.add)),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: controller.l1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.l1[index]['name']),
                      subtitle: Text(controller.l1[index]['mobile']),
                      leading: Image.memory(controller.l1[index]['photo']),
                    );
                  }),
            ),
          ),
        ],
      ),
    ));
  }
}
