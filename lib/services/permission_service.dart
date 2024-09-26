import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  Future<PermissionStatus> requestCameraPermission() async {
    var status = await Permission.storage.request();
    return status;
  }

  Future<PermissionStatus> requestStoragePermission() async {
    var status = await Permission.manageExternalStorage.request();
    var status2 = await Permission.storage.request();
    return status2;
  }

  Future<Map<String, bool>> requestCameraAndStoragePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    bool cameraGranted = statuses[Permission.camera]?.isGranted ?? false;
    bool storageGranted = statuses[Permission.storage]?.isGranted ?? false;

    return {
      'camera': cameraGranted,
      'storage': storageGranted,
    };
  }
}
