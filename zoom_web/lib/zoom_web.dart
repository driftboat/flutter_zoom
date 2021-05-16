import 'dart:async';
import 'dart:js';

import 'package:zoom_platform_interface/zoom_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
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
  Future<bool> startMeeting(ZoomMeetingOptions options) async {}

  @override
  Future<bool> joinMeeting(ZoomMeetingOptions options) async {
    final Completer<bool> completer = Completer();
    final signature = ZoomMtg.generateSignature(SignatureParams(
        meetingNumber: 92133699727,
        apiKey: "3T3vg3hjThKTgHVuCbiXJA",
        apiSecret: "RcDiMKwNORj0R2RfHWRZBmxYznJRMEsHoSIg",
        role: 0));
    ZoomMtg.join(JoinParams(
        meetingNumber: 92133699727,
        userName: "example",
        signature: signature,
        apiKey: "3T3vg3hjThKTgHVuCbiXJA",
        passWord: "111",
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
    throw UnimplementedError('meetingStatus() has not been implemented.');
  }

  @override
  Stream<dynamic> onMeetingStatus() {
    throw UnimplementedError('onMeetingStatus() has not been implemented.');
  }
}
