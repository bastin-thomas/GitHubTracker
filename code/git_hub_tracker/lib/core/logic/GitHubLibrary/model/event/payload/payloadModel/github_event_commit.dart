import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/payloadModel/github_event_author.dart';

class GitHubEventCommit {
    late String sha;
    late GitHubEventAuthor author;
    late String message;
    late bool distinct;
    late String url;

  GitHubEventCommit(Map<String, dynamic> content){
    sha = content['sha'] == null ? 'unkown' : content['sha']!;

    author = GitHubEventAuthor(content['author']== null ? '{}' : content['author']!);

    message = content['message'] == null ? 'unkown' : content['message']!;
    distinct = content['distinct'] == null ? false : content['distinct']!;
    url = content['url'] == null ? 'unkown' : content['url']!;
  }

  @override
  String toString() {
    return '$message, $author';
  }
}