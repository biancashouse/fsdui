import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const _confirmedTokensCollection = '/confirmed-tokens';

  Future<String?> requestToken({
    required String gcrServerUrl,
    required String ea,
    required String appName,
  }) async {
    final response = await http.Client().post(
      Uri.parse('$gcrServerUrl/passwordless/emailUserAConfirmButton'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({'ea': ea, 'app': appName}),
    );
    if (response.statusCode != 200) return null;
    final map = jsonDecode(response.body) as Map<String, dynamic>;
    return map['token'] as String?;
  }

  // Emits true once when the confirmed-tokens/{token} doc appears in Firestore.
  Stream<bool> watchTokenConfirmation(String token) {
    return FirebaseFirestore.instance
        .collection(_confirmedTokensCollection)
        .doc(token)
        .snapshots()
        .map((snap) => snap.exists);
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
