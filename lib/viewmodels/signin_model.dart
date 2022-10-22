import 'package:su_chat_hakan/services/auth_sevice.dart';

class SignInModel {
  final AuthService _authService = AuthService();

  Future<bool?> singIn(String nameSurname, String number, String email,
      String password, String state) async {
    var durum = await _authService.createUser(
        nameSurname, number, email, password, state);

    return durum;
  }
}
