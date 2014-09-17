//
//  TTLocalizableButton.m
//  TurboTrader
//
//  Quick custom component to inject localised string content
//
//  Created by Joe Nash on 17/09/2014.
//  Copyright (c) 2014 Joe Nash. All rights reserved.
//

#import "TTLocalizableButton.h"

@implementation TTLocalizableButton

- (void)awakeFromNib
{
	[self setTitle:NSLocalizedString(self.titleLabel.text, nil) forState:UIControlStateNormal];
}

@end
