import 'package:kukerja_web/core/exceptions/app_exception.dart';

class InvalidInputException extends AppException {
  InvalidInputException(String message): super('Invalid Input: ', message);
}