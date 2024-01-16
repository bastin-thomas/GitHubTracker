import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/utils.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

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
                return LinkLauncher(
                  url: commit.html_url,
                  child: Container(
                    width: double.infinity,
                    decoration: kBoxDecorationInner,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarkdownViewer(
                          EmojiParser().emojify(widget.eventCommit.message),
                          styleSheet: const MarkdownStyle(
                            textStyle: TextStyle(
                                color: kPayloadTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                          selectable: false,
                          enableImageSize: true,
                        ),
                        const Divider(height: 3, color: Colors.transparent,),
                        Row(
                          children: [
                            SmallAvatarWebSource(
                              imagePath: commit.author_avatar,
                            ),
                            const VerticalDivider(color: Colors.white),
                            Text(DisplayDate(commit.date),
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
                height: 70,
                width: double.infinity,
                decoration: kBoxDecorationInner,
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
