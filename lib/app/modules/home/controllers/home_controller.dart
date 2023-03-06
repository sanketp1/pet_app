import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pet_app/app/data/models/petDetails.dart';
import 'package:pet_app/app/data/paths/dataPath.dart';

class HomeController extends GetxController {
  //setting up bool variable for can show or can't show the information as per config.json
  RxBool canShow = false.obs;

  //setting up variable for checking is information loaded or not
  RxBool isLoaded = false.obs;

  //creating method loading the json file
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  //observable list for pet details
  RxList<PetDetails> pets = <PetDetails>[].obs;

  //parsing pets details from json files
  Future<void> parsePetDetails() async {
    final data = await parseJsonFromAssets(DataPaths.petData);

    final petList = data["pets"] as List<dynamic>;

    pets.value = petList
        .map((e) => PetDetails.fromMap(e as Map<String, dynamic>))
        .toList();
    isLoaded.value = true;
  }

  //parsing config details from json files
  Future<void> parseConfigDetails() async {
    final data = await parseJsonFromAssets(DataPaths.configData);
    log(data.toString());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    parsePetDetails();
    parseConfigDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
