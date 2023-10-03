import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;
import 'package:flutter_webrtc/flutter_webrtc.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  RTCPeerConnection? connection;
  RTCSessionDescription? offer;
  TextEditingController localOfferController = TextEditingController();
  TextEditingController remoteAnswerController = TextEditingController();
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

    offer = await connection?.createOffer();
    connection?.setLocalDescription(offer!);
    localOfferController.text = offer!.sdp ?? '';
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
                controller: localOfferController,
                maxLines: 100,
              ),
              // offer != null && offer!.type != null
              //     ? Text(offer!.type!)
              //     : Container(),
              TextField(
                scrollPhysics: NeverScrollableScrollPhysics(),
                controller: remoteAnswerController,
                maxLines: 100,
              ),
              TextButton(
                onPressed: () async {
                  connection?.setRemoteDescription(RTCSessionDescription(
                      remoteAnswerController.text, 'answer'));
                },
                child: const Text("set remote answer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
