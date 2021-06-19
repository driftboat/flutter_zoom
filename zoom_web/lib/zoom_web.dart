import 'dart:async';
import 'dart:js';

import 'package:zoom_platform_interface/zoom_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:zoom_web/stringify_js.dart';
import 'package:zoom_web/zoom_js.dart';
import 'js_interop.dart';
export 'package:zoom_platform_interface/zoom_platform_interface.dart'
    show ZoomOptions, ZoomMeetingOptions;

// _toDartSimpleObject(thing) {
//   var rt = thing.runtimeType.toString();
//   if (thing is JsArray) {
//     List res = new List();
//     JsArray a = thing as JsArray;
//     a.forEach((otherthing) {
//       res.add(_toDartSimpleObject(otherthing));
//     });
//     return res;
//   } else if (thing is JsObject) {
//     Map res = new Map();
//     JsObject o = thing as JsObject;
//     Iterable<String> k = context['Object'].callMethod('keys', [o]);
//     k.forEach((String k) {
//       res[k] = _toDartSimpleObject(o[k]);
//     });
//     return res;
//   } else {
//     return thing;
//   }
// }

class ZoomWeb extends ZoomPlatform {
  StreamController<dynamic>? streamController;
  static void registerWith(Registrar registrar) {
    ZoomPlatform.instance = ZoomWeb();
  }

  @override
  Future<List> initZoom(ZoomOptions options) async {
    final Completer<List> completer = Completer();
    // ZoomMtg.setZoomJSLib('https://dmogdx0jrul3u.cloudfront.net/1.9.1/lib', '/av');
    var sus = ZoomMtg.checkSystemRequirements();

    var susmap = convertToDart(sus);
    print(susmap);
    ZoomMtg.preLoadWasm();
    ZoomMtg.prepareWebSDK();
    ZoomMtg.init(InitParams(
        leaveUrl: "/index.html",
        success: allowInterop((var res) {
          completer.complete([0, 0]);
        }),
        error: allowInterop((var res) {
          completer.complete([1, 0]);
        })));
    return completer.future;
  }

  @override
  Future<bool> startMeeting(ZoomMeetingOptions options) async {
    return false;
  }

  @override
  Future<bool> joinMeeting(ZoomMeetingOptions options) async {
    final Completer<bool> completer = Completer();
    // final signature = ZoomMtg.generateSignature(SignatureParams(
    //     meetingNumber: options.meetingId,
    //     apiKey: options.jwtAPIKey!,
    //     apiSecret: "ApiKey",
    //     role: 0));
    ZoomMtg.join(JoinParams(
        meetingNumber: options.meetingId,
        userName: options.displayName != null ? options.displayName:options.userId,
        signature: options.jwtSignature!,
        apiKey: options.jwtAPIKey!,
        passWord: options.meetingPassword,
        success: allowInterop((var res) {
          completer.complete(true);
        }),
        error: allowInterop((var res) {
          completer.complete(false);
        })));
    return completer.future;
  }

  @override
  Future<List> meetingStatus(String meetingId) async {
    return ["a", "b"];
  }

  @override
  Stream<dynamic> onMeetingStatus() {
    final Completer<bool> completer = Completer();
    streamController?.close();
    streamController = StreamController<dynamic>();
    ZoomMtg.inMeetingServiceListener('onMeetingStatus', allowInterop((status) {
      //print(stringify(MeetingStatus status));
      var r = List<String>.filled(2, "");
      // 1(connecting), 2(connected), 3(disconnected), 4(reconnecting)
      switch (status.meetingStatus) {
        case 1:
          r[0] = "MEETING_STATUS_CONNECTING";
          break;
        case 2:
          r[0] = "MEETING_STATUS_INMEETING";
          break;
        case 3:
          r[0] = "MEETING_STATUS_DISCONNECTING";
          break;
        case 4:
          r[0] = "MEETING_STATUS_INMEETING";
          break;
        default:
          r[0] = status.meetingStatus.toString();
          break;
      }
      streamController!.add(r);
    }));
    return streamController!.stream;
  }
}
