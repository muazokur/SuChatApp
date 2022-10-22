import 'package:flutter/material.dart';
import 'package:su_chat_hakan/screens/adminScreens/adminHome_page.dart';
import 'package:su_chat_hakan/screens/home_page.dart';
import 'package:su_chat_hakan/screens/signin_page.dart';
import 'package:su_chat_hakan/services/auth_sevice.dart';

import '../components/rounded_button.dart';
import '../components/rounded_inputs.dart';
import '../components/toast_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();

  TextEditingController? email = TextEditingController();
  TextEditingController? passwordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              //width: size.width,
              //height: defaultLoginSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HOŞ GELDİNİZ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Image.asset('images/seat_login_logo.png'),
                  RoundedInput(
                    size: size,
                    hintText: 'E-posta',
                    textIcon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    controller: email,
                  ),
                  RoundedInput(
                    size: size,
                    hintText: 'Parola',
                    textIcon: Icons.password,
                    controller: passwordControl,
                  ),
                  const SizedBox(height: 10),
                  RoundedButton(
                    size: size,
                    buttonName: 'GİRİŞ YAP',
                    function: () async {
                      if (email!.text.isNotEmpty) {
                        //veritabanı komutları
                        if (email!.text == 'admin') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminHomePage()),
                          );
                        } else {
                          var chechkUser = await authService.signIn(
                              email!.text.toString(),
                              passwordControl!.text.toString());
                          if (chechkUser == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          } else {
                            ToastMessage.ToastMessageShow(
                                'E-mail veya Parola Hatalı');
                          }
                        }
                      } else {
                        ToastMessage.ToastMessageShow(
                            'Boş Alanları Doldurunuz');
                      }
                    },
                  ),
                  RoundedButton(
                    size: size,
                    buttonName: 'KAYIT OL',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
