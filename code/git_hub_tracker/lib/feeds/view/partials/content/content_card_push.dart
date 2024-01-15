import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_push.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_commit.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_commit.dart';

class ContentCardPush extends ContentCard {
  final GitHubEventPayloadPush payloadPush;

  const ContentCardPush({Key? key, required this.payloadPush}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> commitList = [];
    for (GitHubEventCommit element in payloadPush.commits) {
      commitList.add(const Divider(height: 10, color: Colors.transparent),);
      commitList.add(ContentCardCommit(eventCommit: element));
    }

    return Column(
      children: [
        Column(
          children: commitList,
        ),
        const Divider(height: 4, color: Colors.transparent),
      ],
    );
  }
}