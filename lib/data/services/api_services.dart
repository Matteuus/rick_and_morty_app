import 'package:dio/dio.dart';

abstract class IApiService {
  Future<Map<String, dynamic>> getAllCharacters({String? url});
  Future<Map<String, dynamic>> getCharacterById(int id);
}

class ApiServiceImpl implements IApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getAllCharacters({String? url}) async {
    final endpoint = url ?? '/character';
    final response = await _dio.get(endpoint);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getCharacterById(int id) async {
    final response = await _dio.get('/character/$id');
    return response.data;
  }
}
