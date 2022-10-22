import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:su_chat_hakan/components/admin_pages_view_setting.dart';
import 'package:su_chat_hakan/components/application_my_card.dart';
import 'package:su_chat_hakan/components/card_button.dart';
import 'package:su_chat_hakan/components/rounded_inputs.dart';
import 'package:su_chat_hakan/models/user.dart';
import 'package:su_chat_hakan/viewmodels/users_model.dart';

class UsersPageRequest extends StatefulWidget {
  UsersPageRequest({Key? key}) : super(key: key);

  @override
  State<UsersPageRequest> createState() => _UsersPageRequestState();
}

class _UsersPageRequestState extends State<UsersPageRequest> {
  List<Map<String, dynamic>> listConvertIterable(List<Users>? list) {
    List<Map<String, dynamic>> liste = [];

    liste.clear();
    for (int i = 0; i < list!.length; i++) {
      var ata = list[i].userNumber;

      var mapp = {
        //'userId': list[i].userNumber.toString(),
        'nameSurname': list[i].userNameSurname.toString(),
        'number': list[i].userNumber.toString(),
        'email': list[i].userEmail.toString(),
        'password': list[i].userPassword.toString(),
        'phoneNumber': list[i].userState.toString(),
        'state': list[i].userState.toString(),
        'requestStatus': list[i].requestStatus.toString(),
      };

      liste.add(mapp);
    }
    liste.sort((a, b) => (a['nameSurname']!).compareTo(b['nameSurname']!));
    //print(liste[3]['date']);
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _model = UserModel();

    return AdminPageViewSetting(
      child: ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<Users>>(
                stream: Provider.of<UserModel>(context, listen: false)
                    .getUsersRequest(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Users>> asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return const Center(
                      child: Text('hata oluştu'),
                    );
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      var dateList = asyncSnapshot.data;
                      var iterableList = listConvertIterable(dateList);

                      return Flexible(
                        child: ListView.builder(
                          itemCount: dateList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ApplicationMyCard(
                              cardLeading: Icons.account_circle,
                              txtPhoneNumber: iterableList[index]['state'],
                              txtAddress: iterableList[index]['email'],
                              txtName: iterableList[index]['nameSurname'],
                              txtDate: iterableList[index]['number'],
                              trallingWidgetBottom: CardButton(
                                buttonIcon: Icons.edit,
                                buttonText: 'Onayla',
                                iconColor: Colors.green,
                                onTapCardButton: () {
                                  _model.usersRequestAdmitIt(
                                      iterableList[index]['number'],
                                      iterableList[index]['email'],
                                      iterableList[index]['password']);
                                },
                              ),
                              trallingWidgetMid: CardButton(
                                buttonIcon: Icons.delete,
                                buttonText: 'Reddet',
                                iconColor: Colors.red,
                                onTapCardButton: () {
                                  _model.toRejectUser(
                                      iterableList[index]['email']);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }

  userEdit(String userId, String name, String surname, String phoneNumber,
      String address, UserModel _model) {
    List<TextEditingController?> controller = [
      TextEditingController(text: name),
      TextEditingController(text: surname),
      TextEditingController(text: phoneNumber),
      TextEditingController(text: address),
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Düzenle'),
              content: SingleChildScrollView(
                child: Column(children: [
                  RoundedInput(
                    size: MediaQuery.of(context).size,
                    hintText: 'Ad',
                    inputType: TextInputType.name,
                    textIcon: Icons.account_circle,
                    controller: controller[0],
                  ),
                  RoundedInput(
                    size: MediaQuery.of(context).size,
                    hintText: 'Soyad',
                    inputType: TextInputType.name,
                    textIcon: Icons.account_circle,
                    controller: controller[1],
                  ),
                  RoundedInput(
                    size: MediaQuery.of(context).size,
                    hintText: 'Telefon numarası',
                    inputType: TextInputType.number,
                    textIcon: Icons.phone,
                    controller: controller[2],
                  ),
                  RoundedInput(
                    size: MediaQuery.of(context).size,
                    hintText: '\nAdres',
                    textIcon: Icons.home,
                    inputType: TextInputType.multiline,
                    controller: controller[3],
                    maxLine: 3,
                  ),
                ]),
              ),
            ));
  }
}
