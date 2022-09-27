class LoginModel {
  final String user;
  final String password;

  LoginModel({
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': user});
    result.addAll({'password': password});

    return result;
  }
}
