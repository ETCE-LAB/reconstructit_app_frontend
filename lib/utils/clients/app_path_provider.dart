import 'package:path_provider/path_provider.dart';

class AppPathProvider {
  static Future<String> getAppDocumentsDirectory() async {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> getCredentialsPath() async {
    var docDir = await getApplicationDocumentsDirectory();
    return '${docDir.path}/credentials.json';
  }
}
