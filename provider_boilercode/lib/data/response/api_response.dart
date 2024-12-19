// THIS FILE COMBINES THE STATUS FILE AND GIVES US A RESPONSE FOR THE API CALL

//T is a dynamic func that takes data
import 'status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.data, this.message, this.status);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed() : status = Status.COMPLETED;

  ApiResponse.error() : status = Status.ERROR;

  String toString() {
    return "Status: $status \n Message : $message \n Data: $data";
  }
}
