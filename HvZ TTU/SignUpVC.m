//
//  SignUpVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "SignUpVC.h"
#import <Parse/Parse.h>

@interface SignUpVC ()

@end

@implementation SignUpVC
@synthesize nameField;
@synthesize passwordField;
@synthesize emailField;
@synthesize backButton;
@synthesize signupButton;
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
    
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:keyboardTap];
    
    imageview.image = [UIImage imageNamed:@"mainlogo"];
    
    [signupButton setBackgroundImage:[UIImage imageNamed:@"signup-normal"] forState:UIControlStateNormal];
    [signupButton setBackgroundImage:[UIImage imageNamed:@"signup-highlighted"] forState:UIControlStateHighlighted];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
	// Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [nameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [emailField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)signUp{
    PFUser *user = [[PFUser alloc] init];
    [user setUsername:nameField.text];
    [user setPassword:passwordField.text];
    [user setEmail:emailField.text];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sign Up Complete"
                                                              message:@"Thank you for signing up - you will recieve an email when a mod approves you."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
            
            [self performSegueWithIdentifier:@"signupcomplete" sender:self];
            
        }else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sign Up Error"
                                                              message:@"There was an error signing up. Please try again."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];
}
@end