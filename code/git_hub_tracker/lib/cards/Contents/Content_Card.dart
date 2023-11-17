import 'package:flutter/material.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:git_hub_tracker/partials/Avatar.dart';

class Content_Card extends StatelessWidget {
  const Content_Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: Colors.white10,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}