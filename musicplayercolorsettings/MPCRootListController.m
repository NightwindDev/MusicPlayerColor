/**
 * Copyright (c) 2024 Nightwind
 */

#import <Foundation/Foundation.h>
#import "MPCRootListController.h"

@implementation MPCRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
