import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:su_chat_hakan/services/auth_sevice.dart';
import 'package:su_chat_hakan/services/status_service.dart';
import 'package:su_chat_hakan/services/storage_service.dart';
import 'package:su_chat_hakan/viewmodels/users_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StatusService statusService = StatusService();
  UserModel _model = UserModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  String pickImage = "";
  PickedFile? profileImage;
  late String adam;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    // ignore: unnecessary_null_comparison
    if (profileImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImage!.path)),
        radius: height * 0.08,
      );
    } else {
      if (pickImage != "Fotoğraf Yok") {
        return CircleAvatar(
          backgroundImage: NetworkImage(pickImage),
          radius: height * 0.08,
        );
      } else {
        return CircleAvatar(
          backgroundImage: const AssetImage('assets/images/userdefault.jpg'),
          radius: height * 0.08,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    StorageService _storage = StorageService();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color(0xffFFC107),
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<DocumentSnapshot>(
              stream:
                  _model.getCurrentUser(_auth.currentUser!.email.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading..');
                }
                pickImage = snapshot.data!.get('image').toString();
                var a = snapshot.data!.get('state').toString();
                print(a);
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // const CircleAvatar(
                    //   radius: 70,
                    //   backgroundImage: AssetImage('assets/images/5.jpg'),
                    // ),
                    imagePlace(),
                    TextButton(
                      onPressed: () {
                        //var email = _auth.currentUser!.email;
                        //_onImageButtonPress(ImageSource.gallery, context);
                        if (profileImage != null) {
                          statusService.addStatus(profileImage!,
                              _auth.currentUser!.email.toString());
                        }
                      },
                      child: const Text('Fotoğraf Yükle'),
                    ),
                    TextButton(
                      onPressed: () {
                        _onImageButtonPress(ImageSource.camera, context);
                      },
                      child: const Text('Fotoğraf Çek'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    gestureMethod(Icons.person,
                        snapshot.data!.get('nameSurname').toString()),
                    gestureMethod(
                        Icons.info, snapshot.data!.get('number').toString()),
                    gestureMethod(
                        Icons.email, snapshot.data!.get('email').toString()),
                    gestureMethod(
                        Icons.contacts, snapshot.data!.get('state').toString()),
                    gestureMethod(Icons.exit_to_app, 'Çıkış Yap'),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _onImageButtonPress(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await _imagePicker.getImage(source: source);
      setState(() {
        profileImage = pickedFile;
        print("resim ekelem");
        if (profileImage != null) {}
      });
    } catch (e) {
      pickImage = e.toString();
      print("hata" + pickImage);
    }
  }

  GestureDetector gestureMethod(IconData logo, String title) {
    return GestureDetector(
      onTap: () {
        print("ohara");
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


/*
child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/5.jpg'),
              ),
              TextButton(
                  onPressed: () {
                    var email = _auth.currentUser!.email;
                    print(email);
                  },
                  child: const Text('Fotoğraf Yükle')),
              const SizedBox(
                height: 10,
              ),
              gestureMethod(Icons.person, 'Hakan Öz'),
              gestureMethod(Icons.info, '173311066'),
              gestureMethod(Icons.email, 'Hakan@hotmail.com'),
              gestureMethod(Icons.contacts, 'Öğretim Görevlisi'),
              gestureMethod(Icons.exit_to_app, 'Çıkış Yap'),
            ],
          ),

*/