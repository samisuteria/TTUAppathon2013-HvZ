//
//  OZMapVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "OZMapVC.h"
#import <Parse/Parse.h>
#import "GeoPointAnnotation.h"

@interface OZMapVC ()

@end

@implementation OZMapVC
@synthesize mapView = _mapView;
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
    
   
    
    
        
        PFQuery *humanQuery = [PFUser query];
        [humanQuery whereKey:@"status" equalTo:@"Human"];
        [humanQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                for(PFObject *object in objects){
                    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:object];
                    [self.mapView addAnnotation:annotation];
                }
            }
        }];
   
        PFQuery *zombieQuery = [PFUser query];
        [zombieQuery whereKey:@"status" equalTo:@"Zombie"];
        [zombieQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                for(PFObject *object in objects){
                    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:object];
                    [self.mapView addAnnotation:annotation];
                }
            }
        }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
