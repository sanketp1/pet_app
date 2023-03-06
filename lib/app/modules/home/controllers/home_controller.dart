import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pet_app/app/constants/colors.dart';
import 'package:pet_app/app/data/models/petDetails.dart';
import 'package:pet_app/app/data/paths/dataPath.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikidart/wikidart.dart';

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
  Future<Map<String, dynamic>> parseConfigDetails() async {
    final data = await parseJsonFromAssets(DataPaths.configData);
    return data;
  }

  //method to parse the summary from wikipedia
  Future<String> getWikiSummary(String query) async {
    var res = await Wikidart.searchQuery(query);
    var pageid = res?.results?.first.pageId;
    if (pageid != null) {
      var info = await Wikidart.summary(pageid);

      return info!.extract.toString();
    } else {
      return "";
    }
  }

  //method for launching the url

  Future<void> launchContentUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not launch $url",
          colorText: Colors.white,
          backgroundColor: AppColor.descriptionTextColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isWorkingHours(String workHours) {
    bool isWorkingHrs = false;
    // Get the current date and time
    DateTime now = DateTime.now();

    //intiallizing the  working hours
    int workingHoursStart = 9;
    int workingHoursEnd = 18;

    bool isWeekday(DateTime date) {
      int dayOfWeek = date.weekday;
      // Monday = 1, Friday = 5
      return dayOfWeek >= 1 && dayOfWeek <= 5;
    }

    if (workingHoursStart <= now.hour && workingHoursEnd >= now.hour) {
      if (isWeekday(now)) {
        isWorkingHrs = true;
      }
    }

    return isWorkingHrs;
  }

//method for initiallizing data
  Future<void> intiallize() async {
    final hrs = await parseConfigDetails();
    final workingHrs = hrs["settings"]["workHours"];
    canShow.value = isWorkingHours(workingHrs);
    if (canShow.value) {
      parsePetDetails();
      parseConfigDetails();
    }
  }

  @override
  void onInit() {
    super.onInit();
    intiallize();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
