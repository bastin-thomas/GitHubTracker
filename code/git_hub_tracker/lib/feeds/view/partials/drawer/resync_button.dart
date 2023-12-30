import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

class ReSyncButton extends StatelessWidget {
  const ReSyncButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

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
              const Text("RESYNC", style: TextStyle(color: Colors.white),),

              Container(
                margin: const EdgeInsets.fromLTRB(205, 2, 0, 2),
                child: const Icon(
                  Icons.refresh_outlined,
                  color: Colors.white70,
                ),
              ),
            ]),
      ),
    );
  }
}
