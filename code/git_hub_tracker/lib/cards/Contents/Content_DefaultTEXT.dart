import 'package:flutter/material.dart';
import 'package:git_hub_tracker/cards/Contents/Content_Card.dart';
import 'package:git_hub_tracker/styles/constants.dart';

class Content_DefaultTEXT extends Content_Card {
  const Content_DefaultTEXT({Key? key}) : super(key: key);

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
      child: const Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sit amet dapibus elit, a vehicula risus. In sed massa vel quam elementum rutrum et consectetur turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent lacinia justo in velit pellentesque sagittis.",
        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1)),
      ),
    );
  }
}
