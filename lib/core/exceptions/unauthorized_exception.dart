import 'package:kukerja_web/core/exceptions/app_exception.dart';

class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super('Unauthorized: ', message);
}