import 'package:flutter/material.dart';
import 'package:git_hub_tracker/styles/constants.dart';

class Avatar extends StatelessWidget {
  final String imagePath;

  const Avatar({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: cBoxShadowItem,
      ),
      child: Image(
        image: AssetImage(imagePath),
        width: cDefaultWidth,
        height: cDefaultWidth,
      ),
    );
  }
}
