import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';

class GitHubEventPayloadPublic extends GitHubEventPayload{
  GitHubEventPayloadPublic(String type, Map<String,dynamic> content) : super(type, null);
}