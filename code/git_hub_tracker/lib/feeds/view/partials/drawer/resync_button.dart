import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

class ReSyncButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReSyncButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              Text("RESYNC", style: TextStyle(color: kPayloadTextColor),),
              Icon(
                Icons.refresh_outlined,
                color: Colors.white70,
              ),
            ]),
      ),
    );
  }
}
