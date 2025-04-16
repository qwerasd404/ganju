class AuthService {
  static const defaultUsername = '123';
  static const defaultPassword = '123456';

  static bool login(String username, String password) {
    return username == defaultUsername && password == defaultPassword;
  }
}