//
//  KLBEmployeeTableViewCell.h
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLBEmployeeTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *sectionLabel;
@property (retain, nonatomic) IBOutlet UILabel *ratingLabel;
@end
