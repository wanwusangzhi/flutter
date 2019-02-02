import 'dart:io';
import 'dart:convert';

class ApiHttpClient {
  static get ({url, data}) async {
    var httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers.add('user-agent', '"Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  }
  static dynamic getJSON ({url, path, data, type}) async {
    var httpClient = new HttpClient();
    Uri _uri = Uri.https(url, path, data);
    if (type != null || type == 'http') {
      _uri = Uri.http(url, path, data);
    }
    HttpClientRequest request = await httpClient.getUrl(_uri);
    request.headers.add('user-agent', '"Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');
    request.headers.add('set-cookie', "a=1");
    HttpClientResponse response = await request.close();
    print(request.headers);
    dynamic responseBody = await response.transform(utf8.decoder).join();
    responseBody = json.decode(responseBody);
    return responseBody;
  }
}