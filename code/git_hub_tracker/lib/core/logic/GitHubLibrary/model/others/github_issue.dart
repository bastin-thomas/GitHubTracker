class GitHubIssue{
  late String html_url;
  late String title;
  late String body;
  late Map<String, dynamic> reactions;

  GitHubIssue(Map<String, dynamic> content){
    title = content['title'];
    body = content['body'];
    html_url = content['html_url'];
    reactions = content['reactions'];
  }

  @override
  String toString() {
    return 'repo{$title}';
  }
}