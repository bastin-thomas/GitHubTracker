import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/repository/github_commit.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentCardCommit extends StatefulWidget {
  final GitHubEventCommit eventCommit;

  const ContentCardCommit({super.key, required this.eventCommit});

  @override
  State<ContentCardCommit> createState() => _ContentCardCommitState();
}

class _ContentCardCommitState extends State<ContentCardCommit> {
  late GitHubCommit commit;
  bool singleTap = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(alignment: WrapAlignment.start, children: [
        FutureBuilder<GitHubCommit>(
            future:
                GitHubApiSingleTon.api.getCurrentCommit(widget.eventCommit.url),
            builder: (context, future) {
              if (future.hasData) {
                GitHubCommit commit = future.data!;
                return GestureDetector(
                  onTap: () async {
                    if (singleTap) {
                      if (commit.html_url != Uri.http('127.0.0.1', '/').path) {
                        await launchUrl(commit.html_url);
                      }
                      singleTap = false;
                    }

                    //reset after some times
                    Future.delayed(const Duration(milliseconds: 250))
                        .then((value) {
                      singleTap = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: kBoxDecoration,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          EmojiParser().emojify(widget.eventCommit.message),
                          style: const TextStyle(
                              color: kPayloadTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            SmallAvatarWebSource(
                              imagePath: commit.author_avatar,
                            ),
                            const VerticalDivider(color: Colors.white),
                            Text(
                              commit.date.isBefore(DateTime.now()
                                      .add(const Duration(days: -7)))
                                  ? DateFormat("dd/mm/yyyy HH:mm")
                                      .format(commit.date)
                                  : "${days[commit.date.weekday]} ${commit.date.hour}:${commit.date.minute}",
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                            const VerticalDivider(color: Colors.white),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                children: [
                                  Text(
                                    '+${commit.additions}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 12),
                                  ),
                                  const Text(
                                    ' | ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 12),
                                  ),
                                  Text(
                                    ' -${commit.deletions}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                height: 75,
                width: double.infinity,
                decoration: kBoxDecoration,
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 3,
                ),
              );
            }),
      ]),
    );
  }
}
