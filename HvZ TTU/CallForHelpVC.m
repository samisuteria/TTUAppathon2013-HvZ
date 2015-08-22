//
//  CallForHelpVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "CallForHelpVC.h"
#import <Parse/Parse.h>

@interface CallForHelpVC ()

@end

@implementation CallForHelpVC
@synthesize callButton;
@synthesize locationManager = _locationManager;

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
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        [callButton setBackgroundImage:[UIImage imageNamed:@"PanicNormal"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"PanicHighlight"] forState:UIControlStateHighlighted];
    } else {
        [callButton setBackgroundImage:[UIImage imageNamed:@"PanicNormal4S"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"PanicHighlight4S"] forState:UIControlStateHighlighted];
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed{
    [[self locationManager] startUpdatingLocation];
    
    //CLLocation *location = _locationManager.location;
    //CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"hh:mm a"];
    dateString = [formatter stringFromDate:[NSDate date]];
    
    int helpCalls = [[[PFUser currentUser] objectForKey:@"helpCalls"] intValue];
    
    if(helpCalls < 3){
        
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:@"Player"];
        [push setMessage:[NSString stringWithFormat:@"I'm %@ and I need help! Its currently: %@",[[PFUser currentUser] username], dateString]];
        [push sendPushInBackground];
        
        helpCalls = helpCalls +1;
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Call For Help"
                                                          message:[NSString stringWithFormat:@"You have %d calls for help remaining this game.", (3 - helpCalls)]
                                                         delegate:nil 
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [[PFUser currentUser] incrementKey:@"helpCalls"];
        [[PFUser currentUser] saveEventually];
        
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Too Many Calls For Help"
                                                          message:@"You are only allowed 3 calls for help per game"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    
    
}

@end
