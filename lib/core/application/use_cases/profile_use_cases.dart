import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/profile_port.dart';
import 'package:chefzito/models/user_model.dart';

class ProfileUseCases {
  final ProfilePort _port;

  ProfileUseCases(this._port);

  Future<void> init() => _port.init();

  String get chefName => _port.currentChefName;

  UserModel? get currentUser => _port.currentUser;

  Future<String?> uploadAvatar(Uint8List bytes) => _port.uploadAvatar(bytes);
}
