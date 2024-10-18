// 📦 Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// * State
class PermissionsState {
  final PermissionStatus storage;

  PermissionsState({
    this.storage = PermissionStatus.denied,
  });

  PermissionsState copyWith({
    PermissionStatus? storage,
  }) => PermissionsState(
    storage: storage ?? this.storage,
  );

  get storageGranted {
    return storage == PermissionStatus.granted;
  }
}

// * Notifier State
class PermissionsNotifier extends StateNotifier<PermissionsState> {
  int _androidSdkVersion = 25;

  PermissionsNotifier() : super(PermissionsState()) {
    _init();
  }

  Future<void> _init() async {
    await _getAndroidVersion();
    await _checkPermissions();
  }

  Future<void> _getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _androidSdkVersion = androidInfo.version.sdkInt;
  }

  // Aquí va la lista de permisos a solicitar en un array ordenado manualmente
  Future<void> _checkPermissions() async {
    final permissionsArray = await Future.wait([
      _determineStoragePermission(),
    ]);

    state = state.copyWith(
      storage: permissionsArray[0],
    );
  }

  Future<PermissionStatus> _determineStoragePermission() async {
    return _androidSdkVersion >= 33
      ? Permission.photos.status
      : Permission.storage.status;
  }

  Future<void> requestPhotoLibrary() async {
    final storageStatus = _androidSdkVersion >= 33
      ? await Permission.photos.request()
      : await Permission.storage.request();
    state = state.copyWith(storage: storageStatus);
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

// * Provider
final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});
