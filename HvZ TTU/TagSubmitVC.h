//
//  TagSubmitVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagSubmitVC : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *gameridField;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end
