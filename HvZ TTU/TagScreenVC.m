//
//  TagScreenVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "TagScreenVC.h"
#import <Parse/Parse.h>

@interface TagScreenVC ()

@end

@implementation TagScreenVC
@synthesize locationManager = _locationManager;

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
        
        
        NSString *userStatus = [[PFUser currentUser] objectForKey:@"status"];
        
        if([userStatus isEqualToString:@"Zombie"]){
            self.tabBarItem.title = @"Tag";
            self.tabBarItem.image = [UIImage imageNamed:@"Tags"];
        } else{
            self.tabBarItem.title = @"Call for Help";
            self.tabBarItem.image = [UIImage imageNamed:@"Health-and-Ammo"];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self locationManager] startUpdatingLocation];
    
    CLLocation *location = _locationManager.location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    
    [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
