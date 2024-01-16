import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class ContentCardText extends ContentCard {
  final String text;

  const ContentCardText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: Colors.white10,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: MarkdownViewer(
        EmojiParser().emojify(text),
        styleSheet: const MarkdownStyle(
          textStyle: TextStyle(
              color: kPayloadTextColor,
              fontWeight: FontWeight.normal,
              fontSize: 14),
        ),
      ),
    );
  }
}