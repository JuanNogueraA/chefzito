import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/models/user_model.dart';

abstract class ProfilePort implements InitPort, ChefNamePort {
  UserModel? get currentUser;

  Future<String?> uploadAvatar(Uint8List bytes);
}
