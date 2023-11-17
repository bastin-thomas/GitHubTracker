import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:git_hub_tracker/partials/button.dart';
import 'package:git_hub_tracker/partials/email_input.dart';
import 'package:git_hub_tracker/partials/password_input.dart';
import 'package:git_hub_tracker/screens/FeedPage.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:git_hub_tracker/partials/form_header.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalSpacer,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
