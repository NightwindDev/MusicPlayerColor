/**
 * Copyright (c) 2024 Nightwind
 */

#import <Foundation/Foundation.h>
#import <rootless.h>
#import "MPCColorPickerCell.h"
#import "../Notifications.h"

@implementation MPCColorPickerCell

/**
 * Override the colorPickerViewController:didSelectColor:continuously: method in order to dynamically change the color in the plist.
 */
- (void)colorPickerViewController:(UIColorPickerViewController *)viewController didSelectColor:(UIColor *)color continuously:(BOOL)continuously {
	[super colorPickerViewController:viewController didSelectColor:color continuously:continuously];

	const CGFloat *colorComponents = CGColorGetComponents([color CGColor]);
	NSString *const colorHexString = [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", lroundf(colorComponents[0] * 255), lroundf(colorComponents[1] * 255), lroundf(colorComponents[2] * 255), lroundf(colorComponents[3] * 255)];

	NSString *const prefsPath = @"/var/mobile/Library/Preferences/com.nightwind.musicplayercolorsettings.plist";

	NSMutableDictionary *const prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefsPath] ?: [NSMutableDictionary dictionary];
	[prefs setValue:colorHexString forKey:@"MusicPlayerColor"];
	[prefs writeToFile:prefsPath atomically:YES];

	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:kMusicPlayerColorChangedNotification object:nil];
}

@end