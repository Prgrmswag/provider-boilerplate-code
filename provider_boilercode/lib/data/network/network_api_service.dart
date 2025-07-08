import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart ' as http;

import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
 @override
  Future getGetApiResponse(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      String? token}) async {
    dynamic responseJson;
    try {
      var request = http.Request('GET', Uri.parse(url));

      // Add headers
      Map<String, String> finalHeaders = headers ?? {};
      if (token != null) {
        finalHeaders['Authorization'] = 'Bearer $token';
      }
      request.headers.addAll(finalHeaders);

      // Add body if provided
      if (body != null) {
        request.body = json.encode(body);
      }

      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 10));
      var response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

 @override
  Future getPostApiResponse(String url, dynamic data,
      {String? cookie, String? token, File? file}) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (cookie != null) {
        headers["Cookie"] = "token=$cookie";
      }

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      http.Response response;

      if (file != null) {
        // Multipart request for file upload
        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..headers.addAll(headers)
          ..fields.addAll(data);
        request.files.add(await http.MultipartFile.fromPath('file', file.path));

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        response = await http
            .post(
              Uri.parse(url),
              headers: headers,
              body: jsonEncode(data),
            )
            .timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

 


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201: // CREATED
      case 200: // OK
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;

      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body);
      case 401: // UNAUTHORIZED ACCESS { TOKEN IS MISSING }
        throw UnauthorizedException(response.body);
      case 403:
        throw UnauthorizedException(response.body);
      case 500: // SERVER ERROR
        throw ServerException(response.body);

      default:
        throw FetchDataException(
            'Error Status Code ${response.statusCode}');
    }
  }
}
