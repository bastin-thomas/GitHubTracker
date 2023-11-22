import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:git_hub_tracker/styles/constants.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //await FirebaseAuth.instance.signOut();
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamed(context, kLoginRoute);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        decoration: BoxDecoration(
            boxShadow: cBoxShadowItem,
            color: Colors.black45,
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Row(
            children: [
              const Text("LOGOUT", style: TextStyle(color: Colors.white),),
              Container(
                margin: const EdgeInsets.fromLTRB(205, 2, 0, 2),
                child: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
              ),
            ]),
      ),
    );
  }
}
