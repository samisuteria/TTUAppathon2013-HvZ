//
//  OtherPageVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherPageVC : UIViewController <UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *modButton;
@property (weak, nonatomic) IBOutlet UILabel *loggedInTextField;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
