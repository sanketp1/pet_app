import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/app/constants/colors.dart';
import 'package:pet_app/app/constants/fonts.dart';
import 'package:pet_app/app/data/models/petDetails.dart';
import 'package:pet_app/app/modules/home/controllers/home_controller.dart';
import 'package:skeletons/skeletons.dart';

class PetInfo extends StatelessWidget {
  PetDetails pet;
  HomeController controller;
  PetInfo({super.key, required this.pet, required this.controller});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          pet.title!,
        ),
        centerTitle: GetPlatform.isAndroid ? false : true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 16,
              child: Hero(
                tag: pet.title!,
                child: CachedNetworkImage(
                  imageUrl: pet.image_url!,
                  cacheKey: pet.title,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  pet.title!,
                  style: AppFonts.primaryFont.copyWith(
                      color: AppColor.titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text.rich(TextSpan(
                    text: "Uploaded at: ",
                    style: AppFonts.primaryFont.copyWith(
                      color: AppColor.titleColor,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "${DateFormat("dd-MM-yyyy").format(DateTime.parse(pet.date_added!))}",
                          style: AppFonts.secondaryFont.copyWith(fontSize: 15))
                    ])),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                  onPressed: () async {
                    await controller.launchContentUrl(pet.content_url!);
                  },
                  icon: Icon(Icons.launch),
                  label: Text("More info")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Summary",
                    style: AppFonts.primaryFont.copyWith(fontSize: 16)),
              ),
            ),
            FutureBuilder(
              future: controller.getWikiSummary(pet.title!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        children: [1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10]
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: SkeletonLine(),
                                ))
                            .toList(),
                      ));
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Text(
                        snapshot.data!,
                        style: AppFonts.primaryFont.copyWith(
                            fontSize: 16, color: AppColor.descriptionTextColor),
                        textAlign: TextAlign.justify,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No summary available"),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
