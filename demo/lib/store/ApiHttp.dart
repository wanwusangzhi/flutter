import 'package:dio/dio.dart';
import 'dart:io';
import 'package:demo/config/index.dart';

class ApiHttp {
  constructor() {}
  static Dio apiDio;

  static getHttp([options]) {
    if (ApiHttp.apiDio != null) {
      return ApiHttp.apiDio;
    }
    // create instance
    Dio dio = new Dio(options);
    // proxy
    dio.onHttpClientCreate = (HttpClient client) {
      // client.findProxy = (uri) {
      //   print(Index.proxyUrl);
      //   return Index.proxyUrl;
      // };
    };
    ApiHttp.apiDio = dio;
    return dio;
  }

  static request({method, url, data}) async {
    Response<dynamic> response;
    if (method == 'get') {
      response = await ApiHttp.getHttp().get(url, data: data);
    } else {
      response = await ApiHttp.getHttp().post(url, data: data);
    }
    return response.data;
  }

  // dio.post('/test', data: {id:'123'})
  static Response post(url, [data]) {
    return ApiHttp.getHttp().post(url, data: data);
  }

  // dio.get('/test', {data: {}})
  // dio.get('/test?id=123')
  static get(url, [data]) {
    return ApiHttp.getHttp().get(url, data: data);
  }
}
