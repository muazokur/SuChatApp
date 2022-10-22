import 'package:flutter/material.dart';
import 'package:su_chat_hakan/viewmodels/signin_model.dart';

import '../components/constants.dart';
import '../components/rounded_button.dart';
import '../components/rounded_inputs.dart';
import '../components/toast_message.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

enum SingingCharacter { ogrenci, ogretimGorevlisi }

class _SignInPageState extends State<SignInPage> {
  SingingCharacter? _character = SingingCharacter.ogrenci;
  String durum = 'Öğrenci';
  List<TextEditingController?> controller =
      List.generate(6, (i) => TextEditingController());
  SignInModel _signInModel = SignInModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ekranı'),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Ad Soyad',
                  inputType: TextInputType.name,
                  textIcon: Icons.account_circle,
                  controller: controller[0],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Numara',
                  inputType: TextInputType.phone,
                  textIcon: Icons.account_circle,
                  controller: controller[1],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'E-mail',
                  inputType: TextInputType.emailAddress,
                  textIcon: Icons.email,
                  controller: controller[2],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Parola',
                  textIcon: Icons.home,
                  inputType: TextInputType.visiblePassword,
                  controller: controller[3],
                ),
                ListTile(
                  title: const Text('Öğrenci'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.ogrenci,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        if (_character == SingingCharacter.ogrenci) {
                          durum = 'Öğrenci';
                        }
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Öğretim Üyesi'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.ogretimGorevlisi,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                        if (_character == SingingCharacter.ogretimGorevlisi) {
                          durum = 'Öğretim Görevlisi';
                        }
                      });
                    },
                  ),
                ),
                RoundedButton(
                  size: MediaQuery.of(context).size,
                  buttonName: 'Kayıt Oluştur',
                  function: () async {
                    for (int i = 0; i < 6; i++) {
                      if (controller[i]!.text.isEmpty) {
                        ToastMessage.ToastMessageShow(
                            'Boş alanları doldurunuz');
                        return;
                      } else {
                        var checkCreateUser = await _signInModel.singIn(
                            controller[0]!.text.toString(),
                            controller[1]!.text.toString(),
                            controller[2]!.text.toString(),
                            controller[3]!.text.toString(),
                            durum);
                        if (checkCreateUser == true) {
                          ToastMessage.ToastMessageShow(
                              'Kayıt istediği gönderildi');
                        } else {
                          ToastMessage.ToastMessageShow(
                              'Zaten böyle bir kullanıcı var');
                        }
                        return;
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
