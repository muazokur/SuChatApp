import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const SizedBox(
            height: 3,
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage("assets/images/1.jpg"),
            ),
            tileColor: Colors.white,
            textColor: Colors.black54,
            title: const Text(
              "İlker Ali Özkan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            subtitle: const Text(
              "Öğretim Görevlisi ",
              style: TextStyle(color: Colors.black26, fontSize: 13.0),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Color(0xffFFC107),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 4.0),
          ),
        ],
      ),
    );
  }
}
