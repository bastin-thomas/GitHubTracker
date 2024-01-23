import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/feeds/view/partials/others/apply_button.dart';
import 'package:git_hub_tracker/feeds/view/partials/others/my_simple_select_chips_input.dart';

class ChipsetFilter extends StatelessWidget {
  final Function(String chipsSelected, int Index)? onChipChanged;
  final VoidCallback? onTap;
  final List<int>? Selected;

  const ChipsetFilter({super.key, this.onChipChanged, this.onTap, this.Selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 5, 2, 0),
      height: 110,
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: kMainBackgroundColor,
        borderRadius: kBorderRadius15,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
              MySelectChipsInput(
                  chipsText: const ['Push', 'Fork', 'Create', 'Delete', 'Public', 'Starred', 'Issue','Issue Comment',],
                  separatorCharacter: ";",

                  onTap: onChipChanged,

                  suffixIcons: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':arrow_heading_up:'),
                        style: const TextStyle(fontSize: 17),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':trident:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':new:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':no_entry_sign:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':globe_with_meridians:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':star:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':angry:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(EmojiParser().emojify(':memo:'),
                        style: const TextStyle(fontSize: 20),),
                    ),
                  ],

                  widgetContainerDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.transparent,
                  ),

                  selectedChipDecoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  selectedChipTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),

                  unselectedChipDecoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  unselectedChipTextStyle: const TextStyle(
                    color: Colors.white30,
                    fontSize: 16,
                  ), selectedChipsIndex: Selected ?? [],
                ),
            ),
          ),

          ApplyButton(onTap: onTap,),
        ],
      ),
    );
  }
}



class WaitingFilter extends StatelessWidget {
  const WaitingFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 5, 2, 0),
      height: 110,
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: kMainBackgroundColor,
        borderRadius: kBorderRadius15,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: const Column(
              children: [
                Divider(height: 10, color: Colors.transparent),
                Center(
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                      color: Colors.white24,
                      strokeWidth: 5,
                    ),
                  ),
                ),
                Divider(height: 10, color: Colors.transparent),
              ],
            ),
          ),
          ApplyButton(onTap: (){}),
        ],
      ),
    );
  }
}
