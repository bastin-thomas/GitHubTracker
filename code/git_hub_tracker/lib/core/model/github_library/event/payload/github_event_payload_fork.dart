import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/payload_subtypes/github_event_actor.dart';

class GitHubEventPayloadFork extends GitHubEventPayload{
  late String full_name;
  late GitHubEventActor owner;
  late String html_url;
  late String description;

  GitHubEventPayloadFork(String type, Map<String,dynamic> content) : super(type, null){
    full_name = content['forkee']['full_name'] == null ? 'unkown' : content['forkee']['full_name']!;
    owner = GitHubEventActor(content['forkee']['owner'] == null ? 'unkown' : content['forkee']['owner']!);
    html_url = content['forkee']['html_url'] == null ? 'unkown' : content['forkee']['html_url']!;
    description = content['forkee']['description'] == null ? 'unkown' : content['forkee']['description']!;
  }
}