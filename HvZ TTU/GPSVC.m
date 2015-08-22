//
//  GPSVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "GPSVC.h"
#import <Parse/Parse.h>

@interface GPSVC ()

@end

@implementation GPSVC
@synthesize ozButton;
@synthesize alliesButton;
@synthesize enemyButton;
@synthesize imageview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.tabBarItem.image = [UIImage imageNamed:@"Compass-Button"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        imageview.image = [UIImage imageNamed:@"girl5"];
    } else {
        imageview.image = [UIImage imageNamed:@"girl"];
    }
    
    if([[[PFUser currentUser] objectForKey:@"isOZ"]isEqual: @(NO)]){
        ozButton.hidden = YES;
    }
    
    NSString *userStatus = [[PFUser currentUser] objectForKey:@"status"];
    
    if([userStatus isEqualToString:@"Human"]){
        [alliesButton setBackgroundImage:[UIImage imageNamed:@"allies-humans-normal"] forState:UIControlStateNormal];
        [alliesButton setBackgroundImage:[UIImage imageNamed:@"allies-humans-highlight"] forState:UIControlStateHighlighted];
        [enemyButton setBackgroundImage:[UIImage imageNamed:@"enemies-humans-normal"] forState:UIControlStateNormal];
        [enemyButton setBackgroundImage:[UIImage imageNamed:@"enemies-humans-highlight"] forState:UIControlStateHighlighted];
    
    } else {
        [alliesButton setBackgroundImage:[UIImage imageNamed:@"allies-zombies-normal"] forState:UIControlStateNormal];
        [alliesButton setBackgroundImage:[UIImage imageNamed:@"allies-zombies-highlight"] forState:UIControlStateHighlighted];
        [enemyButton setBackgroundImage:[UIImage imageNamed:@"enemies-zombie-normal"] forState:UIControlStateNormal];
        [enemyButton setBackgroundImage:[UIImage imageNamed:@"enemies-zombie-highlight"] forState:UIControlStateHighlighted];
    }
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
