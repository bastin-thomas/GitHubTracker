import 'package:git_hub_tracker/core/model/github_library/event/payload/payload_subtypes/github_event_comment.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/payload_subtypes/github_event_issue.dart';

class GitHubEventPayloadIssueComment extends GitHubEventPayload{
  late String action;
  late GitHubEventIssue issue;
  late GitHubEventComment comment;

  GitHubEventPayloadIssueComment(String type, Map<String,dynamic> content) : super(type, null){
    action = content['action'] == null ? 'unkown' : content['action']!;
    issue = GitHubEventIssue(content['issue'] == null ? {} : content['issue']!);
    comment = GitHubEventComment(content['comment'] == null ? {} : content['comment']!);
  }

  @override
  String toString() {
    return 'Payload{$type, $action, $issue, $comment}';
  }
}