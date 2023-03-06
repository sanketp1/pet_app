import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pet_app/app/data/models/petDetails.dart';

class PetInfo extends StatelessWidget {
  PetDetails pet;
  PetInfo({super.key, required this.pet});

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
            )
        ,

        
          ],
        
        ),

      ),
    );
  }
}
