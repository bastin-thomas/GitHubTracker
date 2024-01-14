
class GithubOwner {
  late int id;
  late String nodeId;
  late String login;
  late String avatarUrl;
  late String url;
  late String htmlUrl;
  late String type;
  late bool siteAdmin;

  GithubOwner(Map<String, dynamic> content){
    id = content['id'] == null ? -1 : content['id']!;
    nodeId = content['node_id'] == null ? 'unkown' : content['node_id']!;
    login = content['login'] == null ? 'unkown' : content['login']!;
    avatarUrl = content['avatar_url'] == null ? 'https://127.0.0.1/' : content['avatar_url']!;
    url = content['url'] == null ? 'https://127.0.0.1/' : content['url']!;
    htmlUrl = content['html_url'] == null ? 'https://127.0.0.1/' : content['html_url']!;
    type = content['type'] == null ? 'unkown' : content['type']!;
    siteAdmin = content['site_admin'] == null ? false : content['site_admin']!;
  }

  @override
  String toString() {
    return 'repo{$login}';
  }
}