import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.csv');
}

Future<File> writeData(String userData) async {
  final file = await _localFile;
  final originalData = await readData();
  if(originalData.isNotEmpty && originalData.substring(0,12) == userData.substring(0,12))
  {
  return file.writeAsString('$userData,${originalData.substring(13,originalData.length)}');
  }
  else
  {
  return file.writeAsString('$userData,"CRLF",\n$originalData');
  }
}


Future<String> readData() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}
