//
//  MissionsVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"

@interface MissionsVC : UIViewController <PullToRefreshViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
