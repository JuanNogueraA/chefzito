import 'package:chefzito/core/domain/ports/auth_port.dart';

class RegisterUseCase {
  final AuthPort _authPort;

  RegisterUseCase(this._authPort);

  Future<String?> call({
    required String username,
    required String email,
    required String password,
  }) {
    return _authPort.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
