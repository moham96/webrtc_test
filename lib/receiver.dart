import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ReceiverScreen extends StatefulWidget {
  const ReceiverScreen({super.key});

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  RTCPeerConnection? connection;
  RTCSessionDescription? answer;
  TextEditingController localAnswerController = TextEditingController();
  TextEditingController remoteOfferController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Future<void> _init() async {
    connection = await rtc.createPeerConnection({});
    connection?.onConnectionState = (state) {
      print('connection state changed ${state}');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                scrollPhysics: NeverScrollableScrollPhysics(),
                controller: remoteOfferController,
                maxLines: 100,
              ),
              // offer != null && offer!.type != null
              //     ? Text(offer!.type!)
              //     : Container(),
              TextField(
                scrollPhysics: NeverScrollableScrollPhysics(),
                controller: localAnswerController,
                maxLines: 100,
              ),
              TextButton(
                onPressed: () async {
                  connection?.setRemoteDescription(
                    RTCSessionDescription(remoteOfferController.text, 'offer'),
                  );
                  answer = await connection?.createAnswer();
                  localAnswerController.text = answer!.sdp!;
                },
                child: const Text("set remote offer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
