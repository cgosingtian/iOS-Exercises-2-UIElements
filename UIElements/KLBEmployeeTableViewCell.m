//
//  KLBEmployeeTableViewCell.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEmployeeTableViewCell.h"

@implementation KLBEmployeeTableViewCell

@synthesize nameLabel,ratingLabel,sectionLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [ratingLabel release];
    [nameLabel release];
    [sectionLabel release];
    [super dealloc];
}
@end
