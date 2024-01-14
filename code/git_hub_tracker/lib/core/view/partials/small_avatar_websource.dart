import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallAvatarWebSource extends StatelessWidget {
  final String imagePath;

  const SmallAvatarWebSource({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: cBoxShadowItem,
      ),
      child: Image(
        image: CachedNetworkImageProvider(imagePath),
        width: cDefaultWidth/1.5,
        height: cDefaultWidth/1.5,
      ),
    );
  }
}
