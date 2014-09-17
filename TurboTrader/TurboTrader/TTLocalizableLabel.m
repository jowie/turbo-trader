//
//  TTLocalizableLabel.m
//  TurboTrader
//
//  Quick custom component to inject localised string content
//
//  Created by Joe Nash on 17/09/2014.
//  Copyright (c) 2014 Joe Nash. All rights reserved.
//

#import "TTLocalizableLabel.h"

@implementation TTLocalizableLabel

- (void)awakeFromNib
{
	self.text = NSLocalizedString(self.text, nil);
}

@end
