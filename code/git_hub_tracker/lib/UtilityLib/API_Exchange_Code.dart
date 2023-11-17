import 'package:git_hub_tracker/styles/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> exchangeAuthCodeForAccessToken(String authCode) async {
  const tokenEndpoint = 'https://  /api/v2/users/userId';
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  final body = {
    'grant_type': 'authorization_code',
    'client_id': Auth0_ClientId,
    'client_secret': Auth0_ClientSecret,
    'code': authCode,
    'redirect_uri': '${appScheme}://dev-dywnisq364dw45je.eu.auth0.com/android/com.example.git_hub_tracker/callback'
  };

  final response = await http.post(Uri.parse(tokenEndpoint), headers: headers, body: body);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse.containsKey('access_token')) {
      return jsonResponse['access_token'];
    }
  }

  throw Exception('Échec de l\'échange du code d\'autorisation contre un token d\'accès');
}