import 'dart:async';

import 'package:zoom/zoom_platform_interface.dart';

class Zoom {
  Future<List> init(ZoomOptions options) async =>
      ZoomPlatform.instance.initZoom(options);

  Future<bool> startMeeting(ZoomMeetingOptions options) async =>
      ZoomPlatform.instance.startMeeting(options);

  Future<bool> joinMeeting(ZoomMeetingOptions options) async =>
      ZoomPlatform.instance.joinMeeting(options);

  Future<List> meetingStatus(String meetingId) =>
      ZoomPlatform.instance.meetingStatus(meetingId);

  Stream<dynamic> get onMeetingStateChanged =>
      ZoomPlatform.instance.onMeetingStatus();
}
