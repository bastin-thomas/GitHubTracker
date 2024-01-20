class GitHubEventAuthor {
    late String email;
    late String name;

  GitHubEventAuthor(Map<String, dynamic> content){
    email = content['email'] == null ? 'unkown' : content['email']!;
    name = content['name'] == null ? 'unkown' : content['name']!;
  }

  @override
  String toString() {
    return '$name, $email';
  }
}