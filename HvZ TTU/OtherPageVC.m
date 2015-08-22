//
//  OtherPageVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "OtherPageVC.h"
#import <Parse/Parse.h>
#import "UIImageExtras.h"

@interface OtherPageVC (){
    UIImagePickerController *imagePicker;
}

@end

@implementation OtherPageVC
@synthesize modButton;
@synthesize loggedInTextField;
@synthesize thumbnailView;
@synthesize backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.tabBarItem.image = [UIImage imageNamed:@"More"];
        self.tabBarItem.title = @"More";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
	// Do any additional setup after loading the view.
    loggedInTextField.text = [NSString stringWithFormat:@"Logged in as: %@",[[PFUser currentUser]username]];
    
    if([[[PFUser currentUser] objectForKey:@"mod"] isEqual: @(NO)])
    {
        modButton.hidden = YES;
    }
    
    thumbnailView.image = [UIImage imageNamed:@"default-profile"];
    
    PFFile *imageFile = [[PFUser currentUser] objectForKey:@"profilepic"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        thumbnailView.image = image;
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize mainSize = image.size;
    mainSize.height = 500;
    mainSize.width = 500;
    UIImage *sImage = [image imageByBestFitForSize:mainSize]; //[image scaleToFitSize:mainSize];
    
    self.thumbnailView.image = sImage;
    
    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(self.thumbnailView.image, 1.0f)];
    
    [[PFUser currentUser] setObject:imageFile forKey:@"profilepic"];
    [[PFUser currentUser] saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(IBAction)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)imageButtonClicked{
    if(!imagePicker){
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

@end
