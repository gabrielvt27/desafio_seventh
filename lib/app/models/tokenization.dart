import 'dart:convert';

class Tokenization {
  final String accessToken;

  Tokenization({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'X-Access-Token': accessToken});

    return result;
  }

  factory Tokenization.fromMap(Map<String, dynamic> map) {
    return Tokenization(
      accessToken: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tokenization.fromJson(String source) =>
      Tokenization.fromMap(json.decode(source));
}
