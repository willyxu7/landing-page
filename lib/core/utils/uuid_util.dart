import 'package:uuid/uuid.dart';

class UuidUtil {
  static final UuidUtil _instance = UuidUtil._internalConstructor();

  factory UuidUtil() {
    return _instance;
  }

  UuidUtil._internalConstructor();

  String generateUuidV1() {
    var uuid = const Uuid();
    return uuid.v1();
  }

}