//
//  TagConfirmVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "TagConfirmVC.h"
#import <Parse/Parse.h>

@interface TagConfirmVC (){
    NSArray *objects;
}

@end

@implementation TagConfirmVC
@synthesize imageView;
@synthesize nameLabel;
@synthesize locationManager = _locationManager;
@synthesize backButton;
@synthesize confirmButton;

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
    
    imageView.image = [UIImage imageNamed:@"default-profile"];
    nameLabel.text = @"Stephen McFakenamerson";
    
    PFObject *userObject = [objects objectAtIndex:0];
    PFFile *imageFile = [userObject objectForKey:@"profilepic"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        imageView.image = image;
    }];
    
    nameLabel.text = [userObject objectForKey:@"username"];
    
    NSLog(@"count: %d",objects.count);
	// Do any additional setup after loading the view.
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirm-normal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirm-highlight"] forState:UIControlStateHighlighted];

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

-(IBAction)confirmClicked{
    PFObject *newTag = [PFObject objectWithClassName:@"Tags"];
    
    [newTag setObject:nameLabel.text forKey:@"target"];
    
    [[self locationManager] startUpdatingLocation];
    
    CLLocation *location = _locationManager.location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    
    [newTag setObject:geoPoint forKey:@"location"];
    
    [newTag setObject:[[PFUser currentUser] username] forKey:@"username"];
    
    [newTag saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Tag Confirmed"
                                                              message:@"Your tag has been logged"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Database Error"
                                                              message:@"This tag could not be saved."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];
}

- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    
    return _locationManager;
}

@end
