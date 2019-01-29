import 'package:dio/dio.dart';
import 'dart:io';
import 'package:demo/config/Index.dart';

class ApiHttp {
  constructor() {}
  static Dio apiDio;
  
  static getHttp () {
    if (ApiHttp.apiDio != null) {
      print('return instance');
      return ApiHttp.apiDio;
    }
    // create instance
    Dio dio = new Dio();
    // proxy
    dio.onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        print(Index.proxyUrl);
        return Index.proxyUrl;
      };
    };
    print('create instance');
    ApiHttp.apiDio = dio;
    return dio;
  }

  static request(method, data, cb) async {
    Response<dynamic> response = await ApiHttp.getHttp().get('http://baidu.com/bac');
    print(response);
    return response;
  }
  
  // dio.post('/test', data: {id:'123'})
  static post (url, data) {
    return ApiHttp.getHttp().post(url, data);
  }

  // dio.get('/test', {data: {}})
  // dio.get('/test?id=123')
  static get (url, {dynamic data: const {} }) {
    // var urlStr = '';
    // data.forEach((item) {
    //   urlStr = urlStr + (item + '=' + data[item]);
    // });
    // print('out --- ' + urlStr);
    print(data);
    return ApiHttp.getHttp().get(url, { data: data });
  }
}
