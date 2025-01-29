import 'package:provider_boilercode/data/network/app_url.dart';
import 'package:provider_boilercode/data/network/base_api_service.dart';
import 'package:provider_boilercode/data/network/network_api_service.dart';

class LoginRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.login, data);
      return response; 
    } catch (e) {
      throw e;
    }
  }

// Register

  Future<dynamic> registerApi(dynamic data) async {
     try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.register, data);
      return response; 
    } catch (e) {
      throw e;
    }
  }
}
