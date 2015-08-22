//
//  ModsTagMapVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 4/9/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ModsTagMapVC : UIViewController

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
