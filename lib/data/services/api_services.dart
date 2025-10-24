import 'package:dio/dio.dart';

abstract class IApiService {
  Future<Map<String, dynamic>> getAllCharacters({String? url, String? name});
  Future<Map<String, dynamic>> getCharacterById(int id);
}

class ApiServiceImpl implements IApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getAllCharacters({
    String? url,
    String? name,
  }) async {
    final String endpoint;

    if (url != null) {
      endpoint = url;
    } else if (name != null && name.isNotEmpty) {
      endpoint = '/character/?name=$name';
    } else {
      endpoint = '/character';
    }

    final response = await _dio.get(endpoint);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getCharacterById(int id) async {
    final response = await _dio.get('/character/$id');
    return response.data;
  }
}
