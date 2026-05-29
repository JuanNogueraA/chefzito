import 'package:chefzito/core/domain/ports/auth_port.dart';

class LogoutUseCase {
  final AuthPort _authPort;

  LogoutUseCase(this._authPort);

  Future<void> call() {
    return _authPort.logout();
  }
}
