import 'package:kukerja_web/core/exceptions/app_exception.dart';

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super('Error during communication ', message);
}
