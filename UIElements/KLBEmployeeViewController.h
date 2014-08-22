//
//  KLBEmployeeViewController.h
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLBEmployeeViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil section:(NSString *)section index:(NSInteger)index;

- (void)setLanguageButtonText:(NSString *)str;
- (NSString *)section;
- (int)index;

@end
