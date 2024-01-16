// ignore_for_file: unused_import

import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/utils.dart';

class GitHubEventIssue {
  late String url;
  late String repository_url;
  late String labels_url;
  late String comments_url;
  late String events_url;
  late Uri html_url;
  late int id;
  late String node_id;
  late int number;
  late String title;
  late Map<String, dynamic> user;
  late List<dynamic> labels;
  late String state;
  late bool locked;
  late String assignee;
  late List<dynamic> assignees;
  late String milestone;
  late int comments;
  late DateTime created_at;
  late DateTime updated_at;
  late DateTime closed_at;
  late String author_association;
  late String active_lock_reason;
  late String body;
  late Map<String, dynamic> reactions;
  late String timeline_url;
  late String performed_via_github_app;
  late String state_reason;


  GitHubEventIssue(Map<String,dynamic> content){
    url = content['url'] == null ? 'unkown' : content['url']!;
    repository_url = content['repository_url'] == null ? 'unkown' : content['repository_url']!;
    labels_url = content['labels_url'] == null ? 'unkown' : content['labels_url']!;
    comments_url = content['comments_url'] == null ? 'unkown' : content['comments_url']!;
    events_url = content['events_url'] == null ? 'unkown' : content['events_url']!;
    html_url = Uri.parse(content['html_url'] == null ? '127.0.0.1' : content['html_url']!);
    id = content['id'] == null ? 'unkown' : content['id']!;
    node_id = content['node_id'] == null ? 'unkown' : content['node_id']!;
    number = content['number'] == null ? 'unkown' : content['number']!;
    title = content['title'] == null ? 'unkown' : content['title']!;
    user = content['user'] == null ? 'unkown' : content['user']!;
    labels = content['labels'] == null ? 'unkown' : content['labels']!;
    state = content['state'] == null ? 'unkown' : content['state']!;
    locked = content['locked'] == null ? 'unkown' : content['locked']!;
    assignee = content['assignee'] == null ? 'unkown' : content['assignee']!;
    assignees = content['assignees'] == null ? 'unkown' : content['assignees']!;
    milestone = content['milestone'] == null ? 'unkown' : content['milestone']!;
    comments = content['comments'] == null ? 'unkown' : content['comments']!;
    created_at = TimeConverter(content['created_at']);
    updated_at = TimeConverter(content['updated_at']);
    closed_at = TimeConverter(content['closed_at']);
    author_association = content['author_association'] == null ? 'unkown' : content['author_association']!;
    active_lock_reason = content['active_lock_reason'] == null ? 'unkown' : content['active_lock_reason']!;
    body = content['body'] == null ? 'unkown' : content['body']!;
    reactions = content['reactions'] == null ? 'unkown' : content['reactions']!;
    timeline_url = content['timeline_url'] == null ? 'unkown' : content['timeline_url']!;
    performed_via_github_app = content['performed_via_github_app'] == null ? 'unkown' : content['performed_via_github_app']!;
    state_reason = content['state_reason'] == null ? 'unkown' : content['state_reason']!;
  }

  @override
  String toString() {
    return 'Issue: $html_url';
  }
}