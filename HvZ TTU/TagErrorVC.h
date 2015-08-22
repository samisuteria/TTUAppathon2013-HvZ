//
//  TagErrorVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagErrorVC : UIViewController

-(void)setObjects:(NSArray *)passedObjects;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

@end
