
class GitHubCommit {
  late String author_avatar;
  late DateTime date;
  late int additions;
  late int deletions;
  late Uri html_url;

  GitHubCommit(Map<String, dynamic> content){
    author_avatar = content['author']['avatar_url'] ?? 'unknown';
    date = DateTime.parse(content['commit']['author']['date'] ?? DateTime.fromMillisecondsSinceEpoch(0));
    additions = content['stats']['additions'];
    deletions = content['stats']['deletions'];
    html_url = Uri.parse(content['html_url']);
  }

  @override
  String toString() {
    return 'repo{$date}';
  }
}