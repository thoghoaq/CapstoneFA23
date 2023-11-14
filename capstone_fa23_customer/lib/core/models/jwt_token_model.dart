class JwtToken {
  final String sub;
  final String jti;
  final String authRole;
  final int exp;

  JwtToken({
    required this.sub,
    required this.jti,
    required this.authRole,
    required this.exp,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      sub: json['sub'],
      jti: json['jti'],
      authRole: json['AuthRole'],
      exp: json['exp'],
    );
  }
}
