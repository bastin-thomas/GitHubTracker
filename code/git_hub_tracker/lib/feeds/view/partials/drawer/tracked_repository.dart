import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class TrackedRepository extends StatefulWidget {
  const TrackedRepository({Key? key}) : super(key: key);
  @override
  State<TrackedRepository> createState() => _TrackedRepositoryState();
}

class _TrackedRepositoryState extends State<TrackedRepository> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      decoration: BoxDecoration(
          boxShadow: cBoxShadowItem,
          color: Colors.black45,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(children: [
        const Row(
          children: [
            Text(
              "Repository Traqué",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const Divider(height: 5, color: Colors.transparent),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          decoration: BoxDecoration(
              boxShadow: cBoxShadowItem,
              color: Colors.white10,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: SimpleChipsInput(
            separatorCharacter: ";",
            chipContainerDecoration: kBoxDecoration,
            formKey: _loginFormKey,
            validateInput: true,
          ),
        ),
      ]),
    );
  }
}
