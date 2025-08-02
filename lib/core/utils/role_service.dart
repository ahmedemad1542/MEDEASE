import '../storage/storage_helper.dart';
import '../storage/storage_keys.dart';
import 'service_locator.dart';

class RoleService {
  String? _userRole;

  /// Call this method once when the app starts.
  Future<void> init() async {
    _userRole = await sl<StorageHelper>().getData(key: StorageKeys.role);
  }

  bool get isAdmin => _userRole == 'Admin';
  bool get isDoctor => _userRole == 'Doctor';
  bool get isPatient => _userRole == 'Patient';
}
