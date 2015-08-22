//
//  ModPushPageVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "ModPushPageVC.h"
#import <Parse/Parse.h>


@interface ModPushPageVC ()

@end

@implementation ModPushPageVC
@synthesize messageField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    messageField.delegate = self;
	// Do any additional setup after loading the view.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 128) ? NO : YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)sendPush{
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Player"];
    [push setMessage:messageField.text];
    [push sendPushInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
