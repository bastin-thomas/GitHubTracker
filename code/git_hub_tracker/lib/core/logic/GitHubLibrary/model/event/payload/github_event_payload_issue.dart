import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_issue.dart';

class GitHubEventPayloadIssue extends GitHubEventPayload{
  late String action;
  late GitHubEventIssue issue;

  GitHubEventPayloadIssue(String type, Map<String,dynamic> content) : super(type, null){
    action = content['action'] == null ? 'unkown' : content['action']!;
    issue = GitHubEventIssue(content['issue']);
  }

  @override
  String toString() {
    return 'Payload{$type, $action}';
  }

  static const String OPENED = 'opened';
  static const String REOPENED = 'reopened';
  static const String CLOSED = 'closed';


  static const String ASSIGNED = 'assigned';
  static const String UNASSIGNED = 'unassigned';
  static const String EDITED = 'edited';
}