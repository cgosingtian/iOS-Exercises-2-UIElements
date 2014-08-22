//
//  KLBEmployeeViewController.h
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLBEmployeeViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil employeeImage:(UIImage *)image employeeName:(NSString *)name employeeTrainee:(bool)isTrainee employeeRating:(float)rating employeeDescription:(NSString *)description employeeLanguage:(NSString *)language;

- (void)setLanguageButtonText:(NSString *)str;

@end
