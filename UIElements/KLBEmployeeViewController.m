//
//  KLBEmployeeViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEmployeeViewController.h"
#import "KLBConstants.h"
#import "KLBLanguageViewController.h"

@interface KLBEmployeeViewController () <UITextFieldDelegate,UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *employeeImage;
@property (retain, nonatomic) IBOutlet UITextField *employeeNameLabel;
@property (retain, nonatomic) IBOutlet UISwitch *employeeTraineeSwitch;
@property (retain, nonatomic) IBOutlet UISlider *employeeRatingSlider;
@property (retain, nonatomic) IBOutlet UITextView *employeeDescriptionTextView;
@property (retain, nonatomic) IBOutlet UIButton *revertChangesButton;
@property (retain, nonatomic) IBOutlet UILabel *ratingSliderValueLabel;
@property (retain, nonatomic) IBOutlet UILabel *traineeSwitchValueLabel;
@property (retain, nonatomic) IBOutlet UISegmentedControl *clearDescNameSegmentedControl;
@property (retain, nonatomic) IBOutlet UIButton *languageButton;

@property (nonatomic,retain) NSString *originalName;
@property (nonatomic,retain) UIImage *originalImage;
@property (nonatomic) bool originalIsTrainee;
@property (nonatomic) float originalRating;
@property (nonatomic,retain) NSString *originalDescription;
@property (nonatomic,retain) NSString *originalLanguage;

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
    [_ratingSliderValueLabel release];
    [_traineeSwitchValueLabel release];
    [_clearDescNameSegmentedControl release];
    [_languageButton release];
    [_originalLanguage release];
    [super dealloc];
}

#pragma mark - Initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil employeeImage:(UIImage *)image employeeName:(NSString *)name employeeTrainee:(bool)isTrainee employeeRating:(float)rating employeeDescription:(NSString *)description employeeLanguage:(NSString *)language {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _originalImage = image;
        _originalName = name;
        _originalRating = rating;
        _originalIsTrainee = isTrainee;
        _originalDescription = description;
        _originalLanguage = language;
        
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
    _ratingSliderValueLabel.text = [NSString stringWithFormat:@"%f",_originalRating];
    _employeeTraineeSwitch.on = (bool)_originalIsTrainee;
    if (_originalIsTrainee) {
        _traineeSwitchValueLabel.text = @"YES";
    } else _traineeSwitchValueLabel.text = @"NO";
    _employeeDescriptionTextView.text = _originalDescription;
    [_languageButton setTitle:_originalLanguage forState:UIControlStateNormal];
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
    _ratingSliderValueLabel.text = [NSString stringWithFormat:@"%f",_originalRating];
    _employeeTraineeSwitch.on = _originalIsTrainee;
    if (_originalIsTrainee) {
        _traineeSwitchValueLabel.text = @"YES";
    } else _traineeSwitchValueLabel.text = @"NO";
    _employeeDescriptionTextView.text = _originalDescription;
    [_languageButton setTitle:_originalLanguage forState:UIControlStateNormal];
}
- (IBAction)traineeSwitchValueChanged:(id)sender {
    if (_employeeTraineeSwitch.on) {
        _traineeSwitchValueLabel.text = @"YES";
    } else _traineeSwitchValueLabel.text = @"NO";
}
- (IBAction)ratingSliderValueChanged:(id)sender {
    _ratingSliderValueLabel.text = [NSString stringWithFormat:@"%f",_employeeRatingSlider.value];
}
- (IBAction)clearDescNameSegmentedControlHandler:(id)sender {
    switch ([_clearDescNameSegmentedControl selectedSegmentIndex]) {
        case 0: {
            _employeeDescriptionTextView.text = @"";
            break;
        }
        case 1: {
            _employeeNameLabel.text = @"";
            break;
        }
    }
}
- (IBAction)changeLanguage:(id)sender {
    KLBLanguageViewController *lvc = [[KLBLanguageViewController alloc] init];
    [lvc setInitialValue:_languageButton.titleLabel.text];

    [self presentViewController:lvc animated:YES completion:nil];
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

#pragma mark - Utilities
- (void)setLanguageButtonText:(NSString *)str {
    [_languageButton setTitle:str forState:UIControlStateNormal];
}

@end
