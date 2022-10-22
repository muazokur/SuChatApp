import 'package:flutter/material.dart';
import 'package:su_chat_hakan/components/constants.dart';
import 'package:su_chat_hakan/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationMyCard extends StatefulWidget {
  final String? txtName;
  final String? txtPhoneNumber;
  final String? txtAddress;
  final String? txtDate;
  final Widget trallingWidgetMid;
  final Widget trallingWidgetBottom;
  final IconData? cardLeading;

  const ApplicationMyCard({
    Key? key,
    this.txtName,
    this.txtPhoneNumber,
    this.txtAddress,
    this.txtDate,
    this.trallingWidgetMid = const Text(''),
    this.trallingWidgetBottom = const Text(''),
    this.cardLeading,
  }) : super(key: key);

  @override
  State<ApplicationMyCard> createState() => _ApplicationMyCardState();
}

class _ApplicationMyCardState extends State<ApplicationMyCard> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      // ignore: avoid_print
      print('$command bulunamadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              widget.txtName!,
              style: const TextStyle(fontSize: 26),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedButton(
                    size: size,
                    buttonName: 'Ara : ${widget.txtPhoneNumber} ',
                    function: () {
                      customLaunch('tel:${widget.txtPhoneNumber} ');
                    }),
                RoundedButton(
                    size: size,
                    buttonName: 'Mesaj Gönder : ${widget.txtPhoneNumber} ',
                    function: () {
                      customLaunch('sms:${widget.txtPhoneNumber} ');
                    }),
                RoundedButton(
                    size: size, buttonName: 'Adrese Git', function: () {}),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text(
                  'İPTAL',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            leading: widget.cardLeading == null
                ? null
                : Icon(
                    widget.cardLeading,
                    size: 50,
                    color: kPrimaryColor.withAlpha(200),
                  ),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    //color: Colors.yellow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.txtName ?? "bos",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.txtPhoneNumber ?? "bos"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.txtAddress ?? "bos"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.pink,
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.txtDate!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        widget.trallingWidgetMid,
                        widget.trallingWidgetBottom,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
