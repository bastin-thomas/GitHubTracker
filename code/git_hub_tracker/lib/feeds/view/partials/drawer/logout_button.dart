
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/authentication/logic/github_authenticator.dart';
import 'package:git_hub_tracker/core/logic/routing/routes.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';


class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await authenticator.signOut();
        Navigator.pushNamed(context, kAuthRoute,);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        decoration: BoxDecoration(
            boxShadow: cBoxShadowItem,
            color: Colors.black45,
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("LOGOUT", style: TextStyle(color: kPayloadTextColor),),
              Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
            ]),
      ),
    );
  }
}
