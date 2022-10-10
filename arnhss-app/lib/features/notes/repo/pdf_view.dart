import 'dart:io';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfService with HandleException {
  Future<File?> getPdfFromNetwork(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final fileName = url.substring(url.lastIndexOf("/") + 1);
      var data = await http.get(uri);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();

      debugPrint("downloading file...");
      File file = File("${dir.path}/$fileName");
      File urlFile = await file.writeAsBytes(bytes);
      debugPrint("done ");

      return urlFile;
    } catch (e) {
      handleException(e);
      return null;
    }
  }
}
