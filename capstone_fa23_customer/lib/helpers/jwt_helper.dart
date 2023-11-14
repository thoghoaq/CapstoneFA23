import 'package:capstone_fa23_customer/core/enums/shared_preference_key.dart';
import 'package:capstone_fa23_customer/core/models/jwt_token_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JWTHelper {
  Future store(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferenceKey.jwt.name, token);
  }

  Future<JwtToken> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(SharedPreferenceKey.jwt.name);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return JwtToken.fromJson(decodedToken);
    } else {
      throw Exception('Token not found');
    }
  }

  Future<String?> getTokenString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKey.jwt.name);
  }

  Future<String> getRole() async {
    var token = await getToken();
    return token.authRole;
  }

  Future<int> getId() async {
    var token = await getToken();
    return int.parse(token.sub);
  }
}
