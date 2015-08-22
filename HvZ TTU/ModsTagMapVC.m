//
//  ModsTagMapVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 4/9/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "ModsTagMapVC.h"
#import "GeoPointAnnotation.h"
#import <Parse/Parse.h>

@interface ModsTagMapVC () <MKMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation ModsTagMapVC
@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;
@synthesize backButton;

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
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
    
    PFGeoPoint *myLocation = [PFGeoPoint geoPointWithLatitude:33.58777390315338 longitude:-101.876086046607];
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(myLocation.latitude, myLocation.longitude), MKCoordinateSpanMake(0.01, 0.01))];
    
    self.mapView.mapType = MKMapTypeHybrid;
    
    [[self locationManager] startUpdatingLocation];
    
    CLLocation *location = _locationManager.location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    
    [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    if(geoPoint.latitude != 0.0){
        [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.005, 0.005))];
    }
    
    PFQuery *tagQuery = [PFQuery queryWithClassName:@"Tags"];
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray *tags, NSError *error) {
        if (!error) {
            for (PFObject *tag in tags) {
                GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:tag];
                [self.mapView addAnnotation:annotation];
            }
        }
    }];
    
    
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
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
