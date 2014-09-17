//
//  TTRegisterViewController.m
//  TurboTrader
//
//  Created by Joe Nash on 17/09/2014.
//  Copyright (c) 2014 Joe Nash. All rights reserved.
//

#define kTTNotificationRegisterUser			@"kTTNotificationRegisterUser" // would usually create separate constants file and add to the imported headers



#import "TTRegisterViewController.h"


@interface TTRegisterViewController () <UITextFieldDelegate>

@property (nonatomic, assign) IBOutlet UITextField *nameTextField;
@property (nonatomic, assign) IBOutlet UITextField *dobTextField;
@property (nonatomic, assign) IBOutlet UILabel *regionalInfoLabel;
@property (nonatomic, assign) IBOutlet UITextField *regionalInfoTextField;

- (IBAction)submitButton_onTouchUpInside:(UIButton *)sender;

@property (nonatomic, copy) NSString *countryCode;

@end

@implementation TTRegisterViewController


- (void)dealloc
{
	[_countryCode release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// retrieve country region information
	NSLocale *locale = [NSLocale currentLocale];
	self.countryCode = [locale objectForKey: NSLocaleCountryCode];
	
	if([self.countryCode isEqualToString:@"US"])
	{
		// the extra field is additional information
		self.regionalInfoLabel.text = NSLocalizedString(@"register.past", nil);
	}
	else if([self.countryCode isEqualToString:@"DE"])
	{
		// the extra field is financial information
		self.regionalInfoLabel.text = NSLocalizedString(@"register.financial", nil);
	}
	else
	{
		// hide the extra field, GB or other countries
		self.regionalInfoLabel.hidden = YES;
		self.regionalInfoTextField.hidden = YES;
	}
	
	self.nameTextField.delegate = self;
	self.dobTextField.delegate = self;
	self.regionalInfoTextField.delegate = self;
}

#pragma mark - Actions

- (void)submitButton_onTouchUpInside:(UIButton *)sender
{
	NSString *name = self.nameTextField.text;
	NSString *dob = self.dobTextField.text; // in a proper reg situation, we would use some kind of local string validation using RegEx
	NSString *regional = self.regionalInfoTextField.text;
	
	if ([name isEqualToString:@""] || [dob isEqualToString:@""] || [regional isEqualToString:@""])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert.error", nil)
														message:NSLocalizedString(@"alert.incomplete", nil)
													   delegate:nil
											  cancelButtonTitle:NSLocalizedString(@"alert.okay", nil)
											  otherButtonTitles:nil];
		[alert show];
	}
	else
	{
		// e.g. send a notification to a command layer to trigger the network process
		
		NSMutableDictionary *registerData = [NSMutableDictionary dictionaryWithDictionary:@{@"name":name, @"dob":dob}];
		
		if([self.countryCode isEqualToString:@"DE"])
			registerData[@"financial"] = regional;
		else if ([self.countryCode isEqualToString:@"US"])
			registerData[@"past"] = regional;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:kTTNotificationRegisterUser object:self userInfo:registerData];
		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert.done", nil)
														message:nil
													   delegate:nil
											  cancelButtonTitle:NSLocalizedString(@"alert.okay", nil)
											  otherButtonTitles:nil];
		[alert show];
	}
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if(textField == self.nameTextField)
		[self.dobTextField becomeFirstResponder];
	else if(textField == self.dobTextField)
		[self.regionalInfoTextField becomeFirstResponder];
	else
		[textField resignFirstResponder];
    return NO;
}

@end
