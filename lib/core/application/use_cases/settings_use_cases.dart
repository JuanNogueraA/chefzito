import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/core/domain/ports/auth_port.dart';

class SettingsUseCases {
  final InitPort _initPort;
  final ChefNamePort _chefNamePort;
  final AuthPort _authPort;

  SettingsUseCases({
    required InitPort initPort,
    required ChefNamePort chefNamePort,
    required AuthPort authPort,
  })  : _initPort = initPort,
        _chefNamePort = chefNamePort,
        _authPort = authPort;

  Future<void> init() => _initPort.init();

  String get chefName => _chefNamePort.currentChefName;

  Future<void> logout() => _authPort.logout();
}
