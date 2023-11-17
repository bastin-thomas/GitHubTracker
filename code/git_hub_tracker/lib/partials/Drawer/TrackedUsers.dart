import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class TrackedUser extends StatefulWidget {
  const TrackedUser({Key? key}) : super(key: key);
  @override
  State<TrackedUser> createState() => _TrackedUserState();
}

class _TrackedUserState extends State<TrackedUser> {
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
        Row(
          children: const [
            Text(
              "Utilisateurs Traqué",
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
