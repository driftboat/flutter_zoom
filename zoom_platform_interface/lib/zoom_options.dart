class ZoomOptions {
  String domain;
  String? jwtToken;
  String? appKey;
  String? appSecret;
  String? language; //--for web
  bool? showMeetingHeader; //--for web
  bool? disableInvite; //--for web
  bool? disableCallOut; //--for web
  bool? disableRecord; //--for web
  bool? disableJoinAudio; //--for web
  bool? audioPanelAlwaysOpen; //--for web
  bool? isSupportAV; //--for web
  bool? isSupportChat; //--for web
  bool? isSupportQA; //--for web
  bool? isSupportCC; //--for web
  bool? isSupportPolling; //--for web
  bool? isSupportBreakout; //--for web
  bool? screenShare; //--for web
  String? rwcBackup; //--for web
  bool? videoDrag; //--for web
  String? sharingMode; //--for web
  bool? videoHeader; //--for web
  bool? isLockBottom; //--for web
  bool? isSupportNonverbal; //--for web
  bool? isShowJoiningErrorDialog; //--for web
  bool? disablePreview; //--for web
  bool? disableCORP; //--for web
  String? inviteUrlFormat; //--for web
  bool? disableVOIP; //--for web
  bool? disableReport; //--for web
  List<String>? meetingInfo; //--for web

  ZoomOptions(
      {required this.domain,
      this.jwtToken,
      this.appKey,
      this.appSecret,
      this.language = "en-US",
      this.showMeetingHeader = true,
      this.disableInvite = false,
      this.disableCallOut = false,
      this.disableRecord = false,
      this.disableJoinAudio = false,
      this.audioPanelAlwaysOpen = false,
      this.isSupportAV = true,
      this.isSupportChat = true,
      this.isSupportQA = true,
      this.isSupportCC = true,
      this.isSupportPolling = true,
      this.isSupportBreakout = true,
      this.screenShare = true,
      this.rwcBackup = '',
      this.videoDrag = true,
      this.sharingMode = 'both',
      this.videoHeader = true,
      this.isLockBottom = true,
      this.isSupportNonverbal = true,
      this.isShowJoiningErrorDialog = true,
      this.disablePreview = false,
      this.disableCORP = true,
      this.inviteUrlFormat = '',
      this.disableVOIP = false,
      this.disableReport = false,
      this.meetingInfo = const [
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
      ]});
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
  String? jwtAPIKey; //--for web
  String? jwtSignature; //--for web

  ZoomMeetingOptions({
    required this.userId,
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
