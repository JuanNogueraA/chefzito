import 'package:chefzito/core/domain/ports/auth_port.dart';

class LoginUseCase {
  final AuthPort _authPort;

  LoginUseCase(this._authPort);

  Future<String?> call({
    required String email,
    required String password,
  }) {
    return _authPort.login(email: email, password: password);
  }
}
