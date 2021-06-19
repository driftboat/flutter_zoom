class ZoomOptions {
  String domain;
  String jwtToken;

  ZoomOptions({required this.domain, required this.jwtToken});
}

class ZoomMeetingOptions {
  String userId;
  String? displayName;
  String meetingId;
  String meetingPassword;
  String? zoomToken;
  String? zoomAccessToken;
  String disableDialIn;
  String disableDrive;
  String disableInvite;
  String disableShare;
  String noDisconnectAudio;
  String noAudio;
  String? jwtAPIKey;//--for web
  String? jwtSignature;//--for web

  ZoomMeetingOptions(
      {required this.userId,
      required this.meetingId,
      required this.meetingPassword,
      this.displayName,
      this.zoomToken,
      this.zoomAccessToken,
      required this.disableDialIn,
      required this.disableDrive,
      required this.disableInvite,
      required this.disableShare,
      required this.noDisconnectAudio,
      required this.noAudio,
      this.jwtAPIKey,
      this.jwtSignature,
      });
}
