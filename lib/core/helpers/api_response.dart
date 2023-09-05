import '../domain/entities/api_status.dart';

class APIResponse<T> {
  APIStatus status;
  late T data;
  String? message;

  APIResponse(this.status);

  void setLoading() {
    status = APIStatus.loading;
  }

  void setError(String message) {
    status = APIStatus.error;
    this.message = message;
  }

  void setCompleted() {
    status = APIStatus.completed;
  }

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}


