import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gr_zoom/gr_zoom_method_channel.dart';

void main() {
  MethodChannelZoom platform = MethodChannelZoom();
  const MethodChannel channel = MethodChannel('gr_zoom');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
