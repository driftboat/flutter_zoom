import 'dart:async';
import 'dart:convert';
import 'dart:html' hide Platform;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zoom_web/zoom_web.dart';
import 'package:crypto/crypto.dart';

//TODO change with your ApiKey and ApiSecret ,You can generate them according to this guide:
//https://marketplace.zoom.us/docs/guides/build/jwt-app
const jwtAPIKey = "ApiKey";
const jwtAPISecret = "ApiSecret";

class JoinWidget extends StatefulWidget {
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController meetingPasswordController = TextEditingController();
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      appBar: AppBar(
        title: Text('Join meeting'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingIdController,
                    decoration: InputDecoration(
                      labelText: 'Meeting ID',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Meeting Password',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () => joinMeeting(context),
                      child: Text('Join'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () => startMeeting(context),
                      child: Text('Start Meeting'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isMeetingEnded(String status) {
    if (Platform.isAndroid)
      return status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    return status == "MEETING_STATUS_ENDED";
  }

  String generateSignature(
      String apiKey, String apiSecret, String meetingNumber, int role) {
    // Prevent time sync issue between client signature generation and zoom
    final timestamp = DateTime.now().millisecondsSinceEpoch - 30000;
    var str = '${apiKey}${meetingNumber}${timestamp}${role}';
    var bytes = utf8.encode(str);
    final msg = base64.encode(bytes);

    final key = utf8.encode(apiSecret);
    final hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    final digest = hmacSha256.convert(utf8.encode(msg));
    final hash = base64.encode(digest.bytes);

    str = '${apiKey}.${meetingNumber}.${timestamp}.${role}.${hash}';
    bytes = utf8.encode(str);
    final signature = base64.encode(bytes);
    return signature.replaceAll(new RegExp("="), "");
  }

  joinMeeting(BuildContext context) {
    ZoomOptions zoomOptions = new ZoomOptions(
        domain: "zoom.us",
        //https://marketplace.zoom.us/docs/sdk/native-sdks/auth
        //https://jwt.io/
        //--todo from server
        jwtToken: "your jwtToken",
        language: "en-US", // Optional
        showMeetingHeader: true, // Optional
        disableInvite: false, // Optional
        disableCallOut: false, // Optional
        disableRecord: false, // Optional
        disableJoinAudio: false, // Optional
        audioPanelAlwaysOpen: false, // Optional
        isSupportAV: true, // Optional
        isSupportChat: true, // Optional
        isSupportQA: true, // Optional
        isSupportCC: true, // Optional
        isSupportPolling: true, // Optional
        isSupportBreakout: true, // Optional
        screenShare: true, // Optional
        rwcBackup: '', // Optional
        videoDrag: true, // Optional
        sharingMode: 'both', // Optional
        videoHeader: true, // Optional
        isLockBottom: true, // Optional
        isSupportNonverbal: true, // Optional
        isShowJoiningErrorDialog: true, // Optional
        disablePreview: false, // Optional
        disableCORP: true, // Optional
        inviteUrlFormat: '', // Optional
        disableVOIP: false, // Optional
        disableReport: false, // Optional
        meetingInfo: const [
          // Optional
          'topic',
          'host',
          'mn',
          'pwd',
          'telPwd',
          'invite',
          'participant',
          'dc',
          'enctype',
          'report'
        ]);

    var meetingOptions = new ZoomMeetingOptions(
        userId: 'example',
        meetingId: meetingIdController.text,
        meetingPassword: meetingPasswordController.text,
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false");
    var zoom = ZoomWeb();

    zoom.initZoom(zoomOptions).then((results) {
      if (results[0] == 0) {
        // zoom.onMeetingStatus().listen((status) {
        //   print("Meeting Status Stream: " + status[0] + " - " + status[1]);
        //   if (_isMeetingEnded(status[0])) {
        //     timer?.cancel();
        //   }
        // });

        var zr = window.document.getElementById("zmmtg-root");
        querySelector('body').append(zr);
        //The signature should be generated on your server
        final signature = generateSignature(
            jwtAPIKey, jwtAPISecret, meetingIdController.text, 0);
        meetingOptions.jwtAPIKey = jwtAPIKey;
        meetingOptions.jwtSignature = signature;
        zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
          // timer = Timer.periodic(new Duration(seconds: 2), (timer) {
          //   zoom.meetingStatus(meetingOptions.meetingId).then((status) {
          //     print("Meeting Status Polling: " + status[0] + " - " + status[1]);
          //   });
          // });
        });
      }
    });
  }

  startMeeting(BuildContext context) {}
}
