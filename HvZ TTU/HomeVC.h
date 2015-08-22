//
//  HomeVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/17/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "PullToRefreshView.h"


@interface HomeVC : UIViewController <CLLocationManagerDelegate, PullToRefreshViewDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *humanScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *zombieScoreLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@end
