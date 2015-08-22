//
//  TagSubmitVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "TagSubmitVC.h"
#import <Parse/Parse.h>
#import "TagErrorVC.h"
#import "TagConfirmVC.h"

@interface TagSubmitVC (){
    NSArray *results;
}

@end

@implementation TagSubmitVC
@synthesize gameridField;
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
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        imageview.image = [UIImage imageNamed:@"tag5"];
    } else {
        imageview.image = [UIImage imageNamed:@"tag"];
    }
    
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:keyboardTap];
	// Do any additional setup after loading the view.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 9) ? NO : YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [gameridField resignFirstResponder];
    
}

-(IBAction)checkTag{
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"gamerid" equalTo:gameridField.text];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            results = objects;
            if(results.count != 1){
                [self performSegueWithIdentifier:@"gotoTagBad" sender:self];
            } else {
                [self performSegueWithIdentifier:@"gotoTagGood" sender:self];
            }
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"gotoTagBad"]){
        TagErrorVC *vc = [segue destinationViewController];
        [vc setObjects:results];
    } else {
        TagConfirmVC *vc = [segue destinationViewController];
        [vc setObjects:results];
    }
}


@end
