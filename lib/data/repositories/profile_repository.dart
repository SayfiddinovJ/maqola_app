import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/network/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository({required this.profileService});

  Future<UniversalData> getUser() async =>
      await profileService.getUser();
}
