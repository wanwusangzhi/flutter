import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FileReaderUtil {
  static getTempDirectory() async {
    // String _dir = (await getApplicationDocumentsDirectory()).path;
    return (await getApplicationDocumentsDirectory()).path;
  }
  static Future setLocaleFile(String path) async {}

  static Future getLocaleFile(String path) async {
    String _dir = await getTempDirectory();
    print('path=$_dir/$path');
    path = '$_dir/$path';
    print('file exist ? result=${FileSystemEntity.isFileSync(path)}');
    if (FileSystemEntity.isFileSync(path)) {
      return new File(path);
    }
    return await new File('$path').writeAsString('').then((File file) {
      return file;
    });
  }

  static Future readJsonFile(String path) async {
    File file = await getLocaleFile(path);
    String contents = await file.readAsString();
    print('contents = $contents');
    if (contents == null) {
      contents = '{}';
    }
    Map<String, dynamic> _config = json.decode(contents);
    print('_config=$_config');
    return _config;
  }

  static dynamic readValueByKey(String path, String key) async {
    File file = await getLocaleFile(path);
    String contents = await file.readAsString();
    print('contents = $contents');
    Map<String, dynamic> _config = json.decode(contents);
    print('_config=$_config');
    return _config['$key'];
  }
  

  static Future writeJsonFile(String path, Map<String, dynamic> value) async {
    File file = await getLocaleFile(path);
    print('value $value');
    print('value decode = ${json.encode(value)}');
    file.writeAsStringSync(json.encode(value));
    print('file.readAsStringSync() ${file.readAsStringSync()}');
  }
}
