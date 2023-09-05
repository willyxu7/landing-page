import 'package:kukerja_web/core/exceptions/app_exception.dart';

class InternalServerErrorException extends AppException {
  final int statusCode;

  InternalServerErrorException(this.statusCode, String message) : super("Internal server error ", message);

}