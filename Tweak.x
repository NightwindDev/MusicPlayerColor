/**
 * Copyright (c) 2024 Nightwind
 */

#import <UIKit/UIKit.h>
#import <GcUniversal/GcColorPickerUtils.h>
#import <rootless.h>
#import "Notifications.h"

static UIColor *prefs_musicPlayerColor = nil;

static UIColor *const UIColorFromHex(NSString *const hexString) {
	if (!hexString) return nil;

	unsigned rgbValue = 0;
	NSScanner *const scanner = [NSScanner scannerWithString:hexString];
	if ([hexString hasPrefix:@"#"]) {
		scanner.scanLocation = 1;
	}
	[scanner scanHexInt:&rgbValue];

	return [UIColor
		colorWithRed:((rgbValue >> 24) & 0xFF) / 255.0
		green:((rgbValue >> 16) & 0xFF) / 255.0
		blue:((rgbValue >> 8) & 0xFF) / 255.0
		alpha:(rgbValue & 0xFF) / 255.0
	];
}

static void updatePrefs(void) {
	NSDictionary *const prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nightwind.musicplayercolorsettings.plist"];

	if (prefs) {
		prefs_musicPlayerColor = UIColorFromHex([prefs objectForKey:@"MusicPlayerColor"]);
	}
}

@interface MRUNowPlayingView : UIView
@end

%hook MRUNowPlayingView

- (void)didMoveToWindow {
	%orig;

	updatePrefs();
	self.backgroundColor = prefs_musicPlayerColor;

	[[NSDistributedNotificationCenter defaultCenter] addObserverForName:kMusicPlayerColorChangedNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
		updatePrefs();
		self.backgroundColor = prefs_musicPlayerColor;
	}];
}

%end