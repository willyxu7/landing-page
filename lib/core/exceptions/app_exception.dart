class AppException implements Exception {

  final String prefix;
  final String message;

  AppException(this.prefix, this.message,);

  @override
  String toString() {
    return '$prefix$message';
  }

}