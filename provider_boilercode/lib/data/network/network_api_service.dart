import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart ' as http;
import 'package:http/http.dart%20';

import '../app_exceptions.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url,
      {Map<dynamic, dynamic>? headers, String? token}) async {
    dynamic jsonResponse;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Please Check Your Internet Connection');
    }

    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, dynamic data, {String? token}) async {
    dynamic jsonResponse;

    try {
      Response response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Please Check Your Internet Connection');
    }

    return jsonResponse;
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
            'Error with Status Code ${response.statusCode}');
    }
  }
}
