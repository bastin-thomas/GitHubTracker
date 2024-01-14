import 'package:http/http.dart' as http;

///Small HTTP Client overrided to request json type format instead of plain Text
class GitHubOAuthHttpClient extends http.BaseClient {
  final httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return httpClient.send(request);
  }
}