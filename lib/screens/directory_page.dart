import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:su_chat_hakan/components/admin_pages_view_setting.dart';
import 'package:su_chat_hakan/components/get_profileurl.dart';
import 'package:su_chat_hakan/screens/contact_page.dart';
import 'package:su_chat_hakan/viewmodels/users_model.dart';

import '../models/user.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({Key? key}) : super(key: key);

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final UserModel _model = UserModel();

    List<Map<String, dynamic>> listConvertIterable(List<Users>? list) {
      List<Map<String, dynamic>> liste = [];

      liste.clear();
      for (int i = 0; i < list!.length; i++) {
        var ata = list[i].userNumber;
        if (_auth.currentUser!.email == list[i].userEmail) {
          continue;
        }

        var mapp = {
          'userId': list[i].userNumber.toString(),
          'nameSurname': list[i].userNameSurname.toString(),
          'number': list[i].userNumber.toString(),
          'email': list[i].userEmail.toString(),
          'password': list[i].userPassword.toString(),
          'phoneNumber': list[i].userState.toString(),
          'requestStatus': list[i].requestStatus.toString(),
          'image': list[i].image.toString(),
        };

        liste.add(mapp);
      }
      liste.sort((a, b) => (a['nameSurname']!).compareTo(b['nameSurname']!));
      //print(liste[3]['date']);
      return liste;
    }

    return AdminPageViewSetting(
      child: ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<Users>>(
                stream:
                    Provider.of<UserModel>(context, listen: true).getUsers(),
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
                          itemCount: dateList!.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 3.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactPage(
                                        email: iterableList[index]['email'],
                                      ),
                                    ),
                                  );
                                },
                                child: userListTile(
                                    iterableList[index]['image'],
                                    iterableList[index]['nameSurname'],
                                    iterableList[index]['email']),
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

  ListTile userListTile(String profilePhoto, String nameSurname, String mail) {
    return ListTile(
      leading: CircleAvatar(
        radius: 35,
        //backgroundImage: NetworkImage(profilePhoto),
        backgroundImage:
            NetworkImage(GetProfileUrl.getProfileUrl(profilePhoto)),
      ),
      tileColor: Colors.white,
      textColor: Colors.black54,
      title: Text(
        nameSurname,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      subtitle: Text(
        mail,
        style: const TextStyle(color: Colors.black26, fontSize: 13.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 7.0, horizontal: 4.0),
      trailing: const Icon(Icons.exit_to_app),
    );
  }
}
