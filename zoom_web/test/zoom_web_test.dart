import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoom_web/zoom_web.dart';

void main() {
  const MethodChannel channel = MethodChannel('zoom_web');

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
    //expect(await ZoomWeb.platformVersion, '42');
  });
}
