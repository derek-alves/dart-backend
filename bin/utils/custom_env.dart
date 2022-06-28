import 'dart:io';
import 'parser_extension.dart';

class CustomEnv {
  static Map<String, String> _env = {};
  static String _file = '.env';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<T> get<T>({required String key}) async {
    if (_env.isEmpty) await _makeEnv();
    return _env[key]!.toType(T);
  }

  static Future _makeEnv() async {
    List<String> linhas =
        (await _readFile()).replaceAll(String.fromCharCode(13), '').split("\n")
          ..removeWhere(
            (element) => element.isEmpty,
          );

    _env = {
      for (String linha in linhas) linha.split('=')[0]: linha.split('=')[1]
    };
  }

  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}
