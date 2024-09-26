import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathService {
  static Future<void>  moveFileToDownloadDirectory(String filePath) async {
    try {
      // Get the download directory path
      List<Directory>? downloadDirectory = await getExternalStorageDirectories();

      if (downloadDirectory == null) {
        throw 'Could not get the download directory';
      }
    Directory directory=  (new Directory('/storage/emulated/0/Download'));
      directory.exists().then((value) {
        if(!value){
          directory.create();
          }

      });
      String downloadPath = downloadDirectory[1].path;

      // Create a File object for the file to be moved
      File fileToMove = File(filePath);

      // Extract the file name from the file path
      String fileName = fileToMove.path
          .split('/')
          .last;

      // Create a File object for the new location
      File newFile = File('/storage/emulated/0/Download/$fileName');

      // Perform the move operation
      await fileToMove.copy(newFile.path);

      print('File moved to: ${newFile.path}');
    } catch (e) {
      print('Error moving file: $e');
    }
  }
  static Future<void>  deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        print('File deleted successfully: $filePath');
      } else {
        print('File does not exist: $filePath');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}