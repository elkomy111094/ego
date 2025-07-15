import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'dart:convert';

Future<String> hashingData(String data) async {
  final bytes = utf8.encode(data);
  final hashedData = sha256.convert(bytes);
  return hashedData.toString();
}

String encryptData(String hashedData, String secretKey) {
  final key = encrypt.Key.fromUtf8(secretKey.padRight(32, '*'));
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  return encrypter.encrypt(hashedData, iv: iv).base64;
}

String decryptData(String encryptedData, String secretKey) {
  final key = encrypt.Key.fromUtf8(secretKey.padRight(32, '*'));
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  return encrypter.decrypt64(encryptedData, iv: iv);
}
