//
//  Tag_Help_ChooserVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "Tag_Help_ChooserVC.h"
#import <Parse/Parse.h>

@interface Tag_Help_ChooserVC ()

@end

@implementation Tag_Help_ChooserVC

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
	// Do any additional setup after loading the view.
    
    NSString *userStatus = [[PFUser currentUser] objectForKey:@"status"];
    
    if([userStatus isEqualToString:@"Zombie"]){
        [self performSegueWithIdentifier:@"gotoTagHuman" sender:self];
    } else{
        [self performSegueWithIdentifier:@"gotoHelpCall" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
