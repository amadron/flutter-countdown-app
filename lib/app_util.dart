import 'dart:io';

class AppUtil {
  static Future<String> get localPath async {
    final directory = './'; //await getApplicationDocumentsDirectory();
    return directory;
  }

  static Future<File> get localFile async {
    final path = await localPath;
    return File('$path/alerts.txt');
  }
}
