import 'package:kukerja_web/core/exceptions/app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException(String message) : super('Invalid Request: ', message);
}