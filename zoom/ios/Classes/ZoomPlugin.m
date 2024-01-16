#import "ZoomPlugin.h"
#if __has_include(<zoom/zoom-Swift.h>)
#import <zoom/zoom-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zoom-Swift.h"
#endif

@implementation ZoomPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZoomPlugin registerWithRegistrar:registrar];
}
@end
