//
//  ViewController.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/17/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "MainVC.h"
#import <Parse/Parse.h>

@interface MainVC ()

@end

@implementation MainVC
@synthesize imageview;
@synthesize loginButton;
@synthesize signupButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[PFUser currentUser] isAuthenticated]){
        if([[[PFUser currentUser] objectForKey:@"approved"]isEqual: @(YES)]){
            [self performSegueWithIdentifier:@"gotoHomeLoggedIn" sender:self];
        }
        
    }
    
    imageview.image = [UIImage imageNamed:@"mainlogo"];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login-normal"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login-highlighted"] forState:UIControlStateHighlighted];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"signup-normal"] forState:UIControlStateNormal];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"signup-highlighted"] forState:UIControlStateHighlighted];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        imageview.image = [UIImage imageNamed:@"login5"];
    } else {
        imageview.image = [UIImage imageNamed:@"login"];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
