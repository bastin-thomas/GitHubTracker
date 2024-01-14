import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_issuecomment.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_actor.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_repo.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_push.dart';

class GitHubEvent {
  late int id;
  late String type;
  late GitHubEventActor actor;
  late GitHubEventRepo repo;
  late GitHubEventPayload payload;
  late bool public;
  late DateTime created_at;


  GitHubEvent(Map<String, dynamic> content){
    id = int.parse(content["id"] == null ? '-1' : content['id']!);
    type = content["type"] == null ? 'unkown' : content['type']!;
    actor = GitHubEventActor(content["actor"] == null ? {} : content['actor']!);
    repo = GitHubEventRepo(content["repo"] == null ? {} : content['repo']!);

    public = content["public"] == null ? true : content['public']!;
    created_at = DateTime.tryParse(content["created_at"]) ?? DateTime.fromMicrosecondsSinceEpoch(0);

    if(type == GitHubEventPayload.PUSH){
      payload = GitHubEventPayloadPush(type, content['payload']);
    } else
    if(type == GitHubEventPayload.ISSUE_COMMENT){
      payload = GitHubEventPayloadIssueComment(type, content['payload']);
    } else{
      payload = GitHubEventPayload(type, content['payload']);
    }
  }

  @override
  String toString() {
    return '$id, $actor, $repo, $payload';
  }
}