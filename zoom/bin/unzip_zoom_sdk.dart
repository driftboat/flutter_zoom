import 'dart:core';
import 'dart:io';
import 'package:archive/archive.dart';
//import 'package:dio/dio.dart';

void main(List<String> args) async {
  var location = Platform.script.toString();
  if (Platform.isWindows) {
    location = location.replaceFirst("file:///", "");
  } else {
    location = location.replaceFirst("file://", "");
  }
  location = location.replaceFirst("/bin/unzip_zoom_sdk.dart", "");

  // var filename =
  //     location + '/ios-sdk/MobileRTC${(args.length == 0) ? "" : "-dev"}.zip';

  await checkAndDownloadSDK(location);
  // print('Decompressing ' + filename);

  // final bytes = File(filename).readAsBytesSync();

  // final archive = ZipDecoder().decodeBytes(bytes);

  // var current = new File(location + '/ios/MobileRTC.framework/MobileRTC');
  // var exist = await current.exists();
  // if (exist) current.deleteSync();

  // for (final file in archive) {
  //   final filename = file.name;
  //   if (file.isFile) {
  //     final data = file.content as List<int>;
  //     File(location + '/ios/MobileRTC.framework/' + filename)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(data);
  //   }
  // }

  print('Complete');
}

Future<void> checkAndDownloadSDK(String location) async {
  var iosSDKFile = location +
      '/ios/MobileRTC.xcframework/ios-arm64_armv7/MobileRTC.framework/MobileRTC';
  bool exists = await File(iosSDKFile).exists();

  if (!exists) {
    await downloadFile(
        Uri.parse('https://www.dropbox.com/s/44rv7hgvqbgm7j7/MobileRTC?dl=1'),
        iosSDKFile);
  }

  var iosSimulateSDKFile = location +
      '/ios/MobileRTC.xcframework/ios-i386_x86_64-simulator/MobileRTC.framework/MobileRTC';
  exists = await File(iosSimulateSDKFile).exists();

  if (!exists) {
    await downloadFile(
        Uri.parse('https://www.dropbox.com/s/0qx52d1cb45oxku/MobileRTC?dl=1'),
        iosSimulateSDKFile);
  }

  var androidCommonLibFile = location + '/android/libs/commonlib.aar';
  exists = await File(androidCommonLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/lcjoc2evrmeucte/commonlib.aar?dl=1'),
        androidCommonLibFile);
  }
  var androidRTCLibFile = location + '/android/libs/mobilertc.aar';
  exists = await File(androidRTCLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/exe1aa0aflyh53f/mobilertc.aar?dl=1'),
        androidRTCLibFile);
  }
}

Future<void> downloadFile(Uri uri, String savePath) async {
  print('Download ${uri.toString()} to $savePath');
  // var dio = Dio();
  // dio.options.connectTimeout = 1000000;
  // dio.options.receiveTimeout = 1000000;
  // dio.options.sendTimeout = 1000000;
  // await dio.downloadUri(uri, savePath);
  final request = await HttpClient().getUrl(uri);
  final response = await request.close();
  await response.pipe(File(savePath).openWrite());
}
