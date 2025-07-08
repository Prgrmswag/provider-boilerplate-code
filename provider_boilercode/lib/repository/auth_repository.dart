import 'dart:io';

import 'package:provider_boilercode/data/network/app_url.dart';
import 'package:provider_boilercode/data/network/base_api_service.dart';
import 'package:provider_boilercode/data/network/network_api_service.dart';

class LoginRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> postApi(String url , dynamic data , {String? token , File? file }) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(url, data , token:token ,file : file );
      return response;
    } catch (e) {
      rethrow ;
    }
  }


Future<dynamic>getApi(String url , {String? token}) async {

  try {
    dynamic response = await _apiService.getGetApiResponse(url , token: token);
  return response ; 
  
  } catch (e) {
    rethrow ;
  }
}




}
