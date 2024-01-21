import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

class ApplyButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ApplyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool disable = false;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: (){
          if(!disable){
            onTap!();
            disable = true;

            Future.delayed(const Duration(milliseconds: 250)).then((value){
              disable = false;
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 55,
          height: 25,
          decoration: BoxDecoration(
              color: Colors.white24,
              boxShadow: kBoxShadowItem,
              borderRadius: kBorderRadius10
          ),
          child: const Text('APPLY',
          style: TextStyle(color: Colors.white, fontSize: 12),),
        ),
      ),
    );
  }
}