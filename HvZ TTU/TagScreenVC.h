//
//  TagScreenVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TagScreenVC : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
