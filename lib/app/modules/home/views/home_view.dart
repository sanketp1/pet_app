import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_app/app/data/models/petDetails.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Pets',
          ),
          centerTitle: GetPlatform.isAndroid ? false : true,
        ),
        body: GetX<HomeController>(
          builder: (controller) {
            return controller.isLoaded.value
                ? ListView.builder(
                    itemCount: controller.pets.length,
                    itemBuilder: (context, index) {
                      PetDetails pet = controller.pets[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: width,
                          height: height * 0.1,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 8,
                                    offset: Offset(2.0, 2.0))
                              ]),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              leading: CircleAvatar(
                                
                                radius: 32,
                              ),
                              title: Text(pet.title!),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ),
                  );
          },
        ));
  }
}
