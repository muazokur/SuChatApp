import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:su_chat_hakan/components/get_profileurl.dart';
import 'package:su_chat_hakan/screens/conversation_page.dart';
import 'package:su_chat_hakan/viewmodels/users_model.dart';

class ContactPage extends StatelessWidget {
  final String email;
  const ContactPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _model = UserModel();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color(0xffFFC107),
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<DocumentSnapshot>(
              stream: _model.getCurrentUser(email),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading..');
                }

                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(GetProfileUrl.getProfileUrl(
                          snapshot.data!.get('image').toString())),
                    ),
                    // imagePlace(),

                    const SizedBox(
                      height: 10,
                    ),
                    gestureMethod(Icons.message, 'Mesaj Gönder', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConversationPage(
                                  receiveEmail:
                                      snapshot.data!.get('email').toString(),
                                  imageUrl:
                                      snapshot.data!.get('image').toString(),
                                  nameSurname: snapshot.data!
                                      .get('nameSurname')
                                      .toString(),
                                )),
                      );
                    }),
                    gestureMethod(Icons.person,
                        snapshot.data!.get('nameSurname').toString(), () {}),
                    gestureMethod(Icons.info,
                        snapshot.data!.get('number').toString(), () {}),
                    gestureMethod(Icons.email,
                        snapshot.data!.get('email').toString(), () {}),
                    gestureMethod(Icons.contacts,
                        snapshot.data!.get('state').toString(), () {}),
                  ],
                );
              }),
        ),
      ),
    );
  }

  GestureDetector gestureMethod(IconData logo, String title, Function ontap) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            logo,
            color: Colors.grey,
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
