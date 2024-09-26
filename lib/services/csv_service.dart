import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class CSVService {
  final String fileName = 'products.csv';

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  Future<void> saveProducts(List<List<String>> products) async {
    final filePath = await getFilePath();
    final file = File(filePath);
    final csv = const ListToCsvConverter().convert(products);
    await file.writeAsString(csv);
  }

  Future<List<List<dynamic>>> readCSV() async {
    final filePath = await getFilePath();
    final file = File(filePath);

    if (!await file.exists()) {
      return [];
    }

    final existingData = await file.readAsString();
    return CsvToListConverter().convert(existingData);
  }

  Future<void> updateCSV(List<List<String>> newData) async {
    print("HHHHHHHHHHI");
    final filePath = await getFilePath();
    final file = File(filePath);
    List<List<dynamic>> oldData = await readCSV();

    // Convert oldData to a Map for easier comparison

    // Convert newData to a Map for easier comparison
    Map<String, List<dynamic>> newDataMap = {
      for (var row in newData) row[0]: row
    };



    // Convert the Map back to a List for saving
    List<List<dynamic>> updatedData = newDataMap.values.toList();

    final csv = const ListToCsvConverter().convert(updatedData);
    await file.writeAsString(csv);

  }

}
