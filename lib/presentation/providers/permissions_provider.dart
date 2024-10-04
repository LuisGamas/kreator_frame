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
  PermissionsNotifier() : super(PermissionsState()) {
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.photos.status,
    ]);

    state = state.copyWith(
      storage: permissionsArray[0],
    );
  }

  requestPhotoLibrary() async {
    final status = await Permission.photos.request();
    state = state.copyWith(storage: status);
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

// * Provider
final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});