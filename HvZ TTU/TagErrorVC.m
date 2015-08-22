//
//  TagErrorVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "TagErrorVC.h"

@interface TagErrorVC (){
    NSArray *objects;
}

@end

@implementation TagErrorVC
@synthesize numberLabel;
@synthesize commentLabel;
@synthesize backbutton;

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
    
    [backbutton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
    
    if (objects.count == 0) {
        numberLabel.text = [NSString stringWithFormat:@"%d people.",objects.count];
        commentLabel.text = @"You might have a typo.";
    } else{
        numberLabel.text = [NSString stringWithFormat:@"%d people.",objects.count];
        commentLabel.text = @"Which makes no sense.";
    }
    //
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setObjects:(NSArray *)passedObjects{
    objects = passedObjects;
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
