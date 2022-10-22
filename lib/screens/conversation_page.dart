import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:su_chat_hakan/components/constants.dart';
import 'package:su_chat_hakan/components/get_profileurl.dart';
import 'package:su_chat_hakan/components/toast_message.dart';
import 'package:su_chat_hakan/models/conversations.dart';
import 'package:su_chat_hakan/services/storage_service.dart';
import 'package:su_chat_hakan/viewmodels/conversation_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ConversationPage extends StatefulWidget {
  final String receiveEmail;
  final String imageUrl;
  final String nameSurname;
  const ConversationPage(
      {Key? key,
      required this.receiveEmail,
      required this.imageUrl,
      required this.nameSurname})
      : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final StorageService _storage = StorageService();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String conversationId = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conversationId =
        (_auth.currentUser!.email! + '-' + widget.receiveEmail).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(GetProfileUrl.getProfileUrl(widget.imageUrl)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.nameSurname),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 28.0),
            child: Icon(Icons.phone),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ChangeNotifierProvider<ConversationModel>(
                create: (_) => ConversationModel(),
                builder: (context, child) => Scaffold(
                  body: Center(
                      child: Column(
                    children: [
                      StreamBuilder<List<Conversation>>(
                        stream: Provider.of<ConversationModel>(context,
                                listen: true)
                            .getMessages(conversationId),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Conversation>> asyncSnapshot) {
                          if (asyncSnapshot.hasError) {
                            return const Center(
                              child: Text('hata oluştu'),
                            );
                          } else {
                            if (!asyncSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              var dateList = asyncSnapshot.data;

                              return Flexible(
                                child: ListView.builder(
                                  itemCount: dateList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return messageBox(index, dateList);
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
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _editingController,
                        decoration: const InputDecoration(
                            hintText: "Mesaj Gönder", border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    ConversationModel _model = ConversationModel();
                    _model.sendMessage(
                        _auth.currentUser!.email,
                        widget.receiveEmail,
                        _editingController.text,
                        'sender',
                        DateTime.now().toString(),
                        '');
                    _editingController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
                IconButton(
                  onPressed: () async {
                    List _urlFile = await selectFile();
                    ConversationModel _model = ConversationModel();
                    _model.sendMessage(
                        _auth.currentUser!.email,
                        widget.receiveEmail,
                        _urlFile[0],
                        'sender',
                        DateTime.now().toString(),
                        _urlFile[1]);
                    print('osman: $_urlFile');
                  },
                  icon: const Icon(Icons.attach_file),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List> selectFile() async {
    List file = [];
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    print(result);
    if (result == null) return file;
    final path = result.files.single.path!;
    final fileName = result.files.single.name;
    String urlFile = await _storage.uploadFile(fileName, path);
    file.add(fileName);
    file.add(urlFile);
    return file;
  }

  ListTile messageBox(int index, List<Conversation>? messageList) {
    return ListTile(
      title: Align(
        alignment: messageList![index].type == 'sender'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
            ),
            child: messageList[index].filePath == ''
                ? Text(
                    messageList[index].message.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                : InkWell(
                    onTap: () async {
                      String url = messageList[index].filePath.toString();

                      if (await canLaunch(url))
                        await launch(url);
                      else
                        // can't launch url, there is some error
                       
                        ToastMessage.ToastMessageShow(
                            'Erişim seçeneklerinizi kontrol ediniz');
                    },
                    child: Text(
                      messageList[index].message.toString(),
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  )),
      ),
    );
  }
}
