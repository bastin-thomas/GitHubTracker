class GitHubIssueComment{
  late String html_url;
  late String body;
  late Map<String, dynamic> reactions;

  GitHubIssueComment(Map<String, dynamic> content){
    body = content['body'];
    html_url = content['html_url'];
    reactions = content['reactions'];
  }
}