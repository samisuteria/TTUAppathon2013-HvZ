//
//  LoginVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/17/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "LoginVC.h"
#import <Parse/Parse.h>

@interface LoginVC ()

@end

@implementation LoginVC
@synthesize userName;
@synthesize password;
@synthesize backButton;
@synthesize loginButton;
@synthesize imageview;

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
    if([PFUser currentUser]){
        userName.text = [[PFUser currentUser] username];
    }
    
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:keyboardTap];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login-normal"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login-highlighted"] forState:UIControlStateHighlighted];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
    
    imageview.image = [UIImage imageNamed:@"mainlogo"];
	// Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [userName resignFirstResponder];
    [password resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonPressed{
    //NSLog(@"username: %@ password: %@",userName.text,password.text);
    [PFUser logInWithUsernameInBackground:userName.text password:password.text block:^(PFUser *user, NSError *error) {
        if(!error){
//            if([[[PFUser currentUser] objectForKey:@"approved"]isEqual: @(YES)]){
                [self performSegueWithIdentifier:@"gotoHome" sender:self];
//            } else {
//                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Login Error"
//                                                                  message:@"You are not approved yet."
//                                                                 delegate:nil
//                                                        cancelButtonTitle:@"OK"
//                                                        otherButtonTitles:nil];
//                [message show];
//            }
        }
//        else{
//            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Login Error"
//                                                              message:@"There was an error logging in."
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles:nil];
//            [message show];
//        }
    }];
        
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
