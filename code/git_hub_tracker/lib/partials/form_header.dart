import 'package:flutter/material.dart';
import 'package:git_hub_tracker/styles/constants.dart';


class FormHeader extends StatelessWidget {
  const FormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(90)),
            boxShadow: cBoxShadowItem,
          ),
          child: const Image(
            image: AssetImage("assets/images/title.png"),
            width: 150,
            height: 150,
          ),
        ),
        const Text('GitHub Tracker', style: TextStyle(fontSize: 25)),
      ],
    );
  }
}
