import 'dart:io';

abstract class BaseApiService {
//BaseApi services contains all the API's like GET , POST , DELETE .
// BaseApi services are connected to repositories .

  Future<dynamic> getGetApiResponse(String url,
      {Map<String, String>? headers, Map<String, String>? body, String? token});
  Future<dynamic> getPostApiResponse(String url, dynamic data,
      {String? token, String? cookie, File? file});
}
