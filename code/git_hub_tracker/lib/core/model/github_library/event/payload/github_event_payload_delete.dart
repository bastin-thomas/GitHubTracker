import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';

class GitHubEventPayloadDelete extends GitHubEventPayload{
  late String ref;
  late String ref_type;

  GitHubEventPayloadDelete(String type, Map<String,dynamic> content) : super(type, null){
    ref = content['ref'] == null ? 'unkown' : content['ref']!;
    ref_type = content['ref_type'] == null ? 'unkown' : content['ref_type']!;
  }

  static const BRANCH = 'branch';
  static const TAG = 'tag';
}