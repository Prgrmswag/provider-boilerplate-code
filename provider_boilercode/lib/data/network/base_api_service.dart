abstract class BaseApiService {
//BaseApi services contains all the API's like GET , POST , DELETE .
// BaseApi services are connected to repositories .

  Future<dynamic> getGetApiResponse(String url, {Map headers, String token});
  Future<dynamic> getPostApiResponse(String url, dynamic data, {String token});
}
