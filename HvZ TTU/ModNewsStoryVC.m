//
//  ModNewsStoryVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "ModNewsStoryVC.h"
#import <Parse/Parse.h>

@interface ModNewsStoryVC ()

@end

@implementation ModNewsStoryVC
@synthesize textView;
@synthesize authorTextField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submitNewsStory{
    PFObject *newStory = [PFObject objectWithClassName:@"News"];
    [newStory setObject:[textView text] forKey:@"Story"];
    [newStory setObject:authorTextField.text forKey:@"Author"];
    NSDate *now = [NSDate date];
    [newStory setObject:now forKey:@"Date"];
    [newStory saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
