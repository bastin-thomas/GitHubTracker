import 'package:flutter/material.dart';
import 'package:git_hub_tracker/partials/Avatar_Websource.dart';

class MyUserTag extends StatelessWidget {
  final String image;
  final String userName;

  const MyUserTag({required this.userName, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarWebSource(imagePath: image),
        const VerticalDivider(),
        Text(userName),
      ],
    );
  }
}
