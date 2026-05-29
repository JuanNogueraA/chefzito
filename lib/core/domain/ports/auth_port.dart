abstract class AuthPort {
  Future<String?> login({
    required String email,
    required String password,
  });

  Future<String?> register({
    required String username,
    required String email,
    required String password,
  });

  Future<void> logout();
}
