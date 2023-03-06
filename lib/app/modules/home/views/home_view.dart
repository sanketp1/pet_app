import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_app/app/constants/colors.dart';
import 'package:pet_app/app/constants/fonts.dart';
import 'package:pet_app/app/data/models/petDetails.dart';
import 'package:pet_app/app/modules/home/views/pet_info_view.dart';
import 'package:skeletons/skeletons.dart';

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
            return controller.canShow.value
                ? controller.isLoaded.value
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
                                  onTap: () {
                                    Get.to(() => PetInfo(
                                          pet: pet,
                                          controller: controller,
                                        ));
                                  },
                                  leading: Hero(
                                    tag: pet.title!,
                                    child: CachedNetworkImage(
                                      cacheKey: pet.title,
                                      imageUrl: pet.image_url!,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 32,
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            shape: BoxShape.circle,
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
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
                      )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm_off_sharp,
                          size: 50,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Working hours are closed",
                          style: AppFonts.primaryFont.copyWith(
                              color: AppColor.descriptionTextColor,
                              fontSize: 20),
                        )
                      ],
                    ),
                  );
          },
        ));
  }
}
