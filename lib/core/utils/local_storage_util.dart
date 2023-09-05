import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageUtil {
  static const FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage();

  static Future<void> writeId(String id) async {
    await _flutterSecureStorage.write(key: "id", value: id);
  }

  static Future<String?> readId() async {
    return await _flutterSecureStorage.read(key: "id");
  }

  static Future<String?> readAccessToken() async {
    return await _flutterSecureStorage.read(key: "tokenIssue");
  }

  static Future<void> writeAccessToken(String accessToken) async {
    await _flutterSecureStorage.write(key: "tokenIssue", value: accessToken);
  }

  static Future<String?> readPhoneNumber() async {
    return await _flutterSecureStorage.read(key: "phone");
  }

  static Future<void> writePhoneNumber(String phoneNumber) async {
    await _flutterSecureStorage.write(key: "phone", value: phoneNumber);
  }

  static Future<String?> readUserName() async {
    return await _flutterSecureStorage.read(key: "name");
  }

  static Future<void> writeUserName(String name) async {
    await _flutterSecureStorage.write(key: "name", value: name);
  }

  static Future<void> deleteAll() async {
    await _flutterSecureStorage.deleteAll();
  }

  static Future<void> writeFromTalentPool() async {
    await _flutterSecureStorage.write(key: "talentPool", value: "true");
  }

  static Future<void> deleteFromTalentPool() async {
    await _flutterSecureStorage.delete(key: "talentPool");
  }

  static Future<String?> readFromTalentPool() async {
    return await _flutterSecureStorage.read(key: "talentPool");
  }

  static Future<void> writeFromSultanRecruitment() async {
    await _flutterSecureStorage.write(key: "sultanRecruitment", value: "true");
  }

  static Future<void> deleteFromSultanRecruitment() async {
    await _flutterSecureStorage.delete(key: "sultanRecruitment");
  }

  static Future<String?> readFromSultanRecruitment() async {
    return await _flutterSecureStorage.read(key: "sultanRecruitment");
  }

}
