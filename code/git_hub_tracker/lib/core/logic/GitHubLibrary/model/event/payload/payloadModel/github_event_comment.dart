
class GitHubEventComment {
  late String url;
  late String html_url;
  late String issue_url;
  late int id;
  late String node_id;
  late Map<String, dynamic> user;
  late String created_at;
  late String updated_at;
  late String author_association;
  late String body;
  late Map<String, dynamic> reactions;
  late String performed_via_github_app;


  GitHubEventComment(Map<String,dynamic> content){
    url = content['url'] == null ? 'unkown' : content['url']!;
    html_url = content['html_url'] == null ? 'unkown' : content['html_url']!;
    issue_url = content['issue_url'] == null ? 'unkown' : content['issue_url']!;
    id = content['id'] == null ? -1 : content['id']!;
    node_id = content['node_id'] == null ? 'unkown' : content['node_id']!;
    user = content['user'] == null ? {} : content['user']!;
    created_at = content['created_at'] == null ? 'unkown' : content['created_at']!;
    updated_at = content['updated_at'] == null ? 'unkown' : content['updated_at']!;
    author_association = content['author_association'] == null ? 'unkown' : content['author_association']!;
    body = content['body'] == null ? 'unkown' : content['body']!;
    reactions = content['reactions'] == null ? 'unkown' : content['reactions']!;
    performed_via_github_app = content['performed_via_github_app'] == null ? 'performed_via_github_app' : content['url']!;
  }

  @override
  String toString() {
    return 'Comment: $html_url';
  }
}