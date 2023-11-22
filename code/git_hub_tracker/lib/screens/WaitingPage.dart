import 'package:flutter/material.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:git_hub_tracker/partials/form_header.dart';

class WaitingPage extends StatelessWidget {
  WaitingPage({Key? key}) : super(key: key);
  //final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHorizontalSpacer,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FormHeader(),
                ),
                SizedBox(
                  height: kVerticalSpacer * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
