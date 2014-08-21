//
//  KLBEmployeeViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEmployeeViewController.h"
#import "KLBConstants.h"

@interface KLBEmployeeViewController () <UITextFieldDelegate,UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *employeeImage;
@property (retain, nonatomic) IBOutlet UITextField *employeeNameLabel;
@property (retain, nonatomic) IBOutlet UISwitch *employeeTraineeSwitch;
@property (retain, nonatomic) IBOutlet UISlider *employeeRatingSlider;
@property (retain, nonatomic) IBOutlet UITextView *employeeDescriptionTextView;
@property (retain, nonatomic) IBOutlet UIButton *revertChangesButton;

@property (nonatomic,retain) NSString *originalName;
@property (nonatomic,retain) UIImage *originalImage;
@property (nonatomic) bool originalIsTrainee;
@property (nonatomic) float originalRating;
@property (nonatomic,retain) NSString *originalDescription;

@end

@implementation KLBEmployeeViewController

#pragma mark - Dealloc
- (void)dealloc {
    [_employeeImage release];
    [_employeeNameLabel release];
    [_employeeTraineeSwitch release];
    [_employeeRatingSlider release];
    [_employeeDescriptionTextView release];
    [_revertChangesButton release];
    
    [_originalImage release];
    [_originalDescription release];
    [_originalName release];
    [super dealloc];
}

#pragma mark - Initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil employeeImage:(UIImage *)image employeeName:(NSString *)name employeeTrainee:(bool)isTrainee employeeRating:(float)rating employeeDescription:(NSString *)description {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _originalImage = image;
        _originalName = name;
        _originalRating = rating;
        _originalIsTrainee = isTrainee;
        _originalDescription = description;
        
        //[image release];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View States
- (void)viewDidLoad
{
    [super viewDidLoad];
    _employeeImage.image = _originalImage;
    _employeeNameLabel.text = _originalName;
    _employeeRatingSlider.minimumValue = KLB_MINIMUM_RATING;
    _employeeRatingSlider.maximumValue = KLB_MAXIMUM_RATING;
    [_employeeRatingSlider setValue:_originalRating];
    _employeeTraineeSwitch.on = (bool)_originalIsTrainee;
    _employeeDescriptionTextView.text = _originalDescription;
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)revertChanges:(id)sender {
    _employeeImage.image = _originalImage;
    _employeeNameLabel.text = _originalName;
    _employeeRatingSlider.value = _originalRating;
    _employeeTraineeSwitch.on = _originalIsTrainee;
    _employeeDescriptionTextView.text = _originalDescription;
}
- (IBAction)dismissResponders:(id)sender {
    [[self view] endEditing:YES];
}

#pragma mark - UITextFieldDelegate Protocol
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UITextViewDelegate Protocol
- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGRect frame = [textView frame];
    frame.origin.y /= 3.0;
    [textView setFrame:frame];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    CGRect frame = [textView frame];
    frame.origin.y *= 3.0;
    [textView setFrame:frame];
}
@end
