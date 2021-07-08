//
//  zoom_customui.h
//  zoom_customui
//
//  Created by Y.X. Xiong on 2021/6/20.
//

#import <Foundation/Foundation.h>

//! Project version number for zoom_customui.
FOUNDATION_EXPORT double zoom_customuiVersionNumber;

//! Project version string for zoom_customui.
FOUNDATION_EXPORT const unsigned char zoom_customuiVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <zoom_customui/PublicHeader.h>


@interface ZoomCustomUI : NSObject 

-(void)onInitMeetingView;
-(void)onDestroyMeetingView;
@end
