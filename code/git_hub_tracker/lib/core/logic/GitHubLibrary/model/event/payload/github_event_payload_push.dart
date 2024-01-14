import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';

class GitHubEventPayloadPush extends GitHubEventPayload{
  late int repo_id;
  late int push_id;
  late int size;
  late int distinct_size;
  late String ref;
  late String head;
  late String before;
  final List<GitHubEventCommit> commits = [];

  GitHubEventPayloadPush(type, Map<String, dynamic> content) : super(type, null){
    //print(content);
    repo_id = content['repository_id'] == null ? -1 : content['repository_id']!;
    push_id = content['push_id'] == null ? -1 : content['push_id']!;
    size = content['size'] == null ? 0 : content['size']!;
    distinct_size = content['distinct_size'] == null ? 0 : content['distinct_size']!;
    ref = content['ref'];
    head = content['head'];
    before = content['before'];


    List<dynamic> tmp = content['commits'];
    tmp.forEach((element) {
      commits.add(GitHubEventCommit(element));
    });
  }

  @override
  String toString() {
    StringBuffer commitList = StringBuffer('Commits:{');
    for (var element in commits) {
      commitList.write(' $element,');
    }
    commitList.write('}');

    return 'Payload{$type, ${commitList.toString()}}';
  }
}