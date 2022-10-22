import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:su_chat_hakan/components/admin_pages_view_setting.dart';
import 'package:su_chat_hakan/components/get_profileurl.dart';
import 'package:su_chat_hakan/models/user.dart';
import 'package:su_chat_hakan/screens/conversation_page.dart';
import 'package:su_chat_hakan/services/database_service.dart';
import 'package:su_chat_hakan/viewmodels/users_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final UserModel _model = UserModel();
    final DatabaseService _dbservice = DatabaseService();

    List<Map<String, dynamic>> listConvertIterable(List<Users>? list) {
      List<Map<String, dynamic>> liste = [];

      liste.clear();
      for (int i = 0; i < list!.length; i++) {
        //-1 ekle
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
        var chatUserList = _dbservice.getConversationId(
            'Conversations', _auth.currentUser!.email.toString());
        print(chatUserList);
        liste.add(mapp);
      }

      print(liste[1]['email']);
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
                    Provider.of<UserModel>(context, listen: true).getChats(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Users>> asyncSnapshot) {
                  if (asyncSnapshot.hasError && asyncSnapshot.data == null) {
                    return const Center(
                      child: Text('-'),
                    );
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      var dateList = asyncSnapshot.data;

                      var iterableList = listConvertIterable(dateList);

                      return Flexible(
                        child: ListView.builder(
                          itemCount: iterableList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 3.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ContactPage(
                                  //       email: iterableList[index]['email'],
                                  //     ),
                                  //   ),
                                  // );
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
