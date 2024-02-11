class LoginResponse {
  String? accessToken;
  String? type = "Bearer";
  String? id;
  String? username;
  String? email;
  List<dynamic>? roles;

  LoginResponse(
      {this.accessToken,
      this.type,
      this.id,
      this.username,
      this.email,
      this.roles});

  static LoginResponse fromJson(Map<String, dynamic> map) {
    return LoginResponse(
        accessToken: map['accessToken'],
        type: map['tokenType'],
        id: map['id'],
        username: map['username'],
        email: map['email'],
        roles: map['roles']);
  }
}
