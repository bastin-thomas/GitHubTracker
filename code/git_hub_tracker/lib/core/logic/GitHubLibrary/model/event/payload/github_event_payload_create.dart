import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';

class GitHubEventPayloadCreate extends GitHubEventPayload{
  late String ref;
  late String ref_type;
  late String master_branch;
  late String description;
  late String pusher_type;

  GitHubEventPayloadCreate(String type, Map<String,dynamic> content) : super(type, null){
    ref = content['ref'] == null ? 'unkown' : content['ref']!;
    ref_type = content['ref_type'] == null ? 'unkown' : content['ref_type']!;
    master_branch = content['master_branch'] == null ? 'unkown' : content['master_branch']!;
    description = content['description'] == null ? 'unkown' : content['description']!;
    pusher_type = content['pusher_type'] == null ? 'unkown' : content['pusher_type']!;
  }

  static const BRANCH = 'branch';
  static const TAG = 'tag';
  static const REPOSITORY = 'repository';
}