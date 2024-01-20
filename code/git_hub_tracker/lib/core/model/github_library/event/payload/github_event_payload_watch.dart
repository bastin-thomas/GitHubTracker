import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';

class GitHubEventPayloadWatch extends GitHubEventPayload{
  late String action;

  GitHubEventPayloadWatch(String type, Map<String,dynamic> content) : super(type, null){
    action = content['action'] == null ? 'unkown' : content['action']!;
  }

  @override
  String toString() {
    return 'Payload{$type, $action}';
  }
}