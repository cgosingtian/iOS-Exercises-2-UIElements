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
#import "KLBEmployeeStore.h"

@interface KLBEmployeeViewController () <UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *employeeImage;
@property (retain, nonatomic) IBOutlet UITextField *employeeNameField;
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

@property (nonatomic,retain) NSMutableDictionary *employee;
@property (nonatomic) NSString *section;
@property (nonatomic) int index;

@property (nonatomic) bool keyboardIsShown;

@end

@implementation KLBEmployeeViewController

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_employeeImage release];
    [_employeeNameField release];
    [_employeeTraineeSwitch release];
    [_employeeRatingSlider release];
    [_employeeDescriptionTextView release];
    [_revertChangesButton release];
    [_employee release];
    
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil section:(NSString *)section index:(NSInteger)index {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _section = section;
        _index = index;

        [self refreshData];
        
        _keyboardIsShown = false;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

//Designated Initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _keyboardIsShown = false;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - View States
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *takePictureButton = [[UIBarButtonItem alloc] initWithTitle:@"Pic" style:UIBarButtonItemStylePlain target:self action:@selector(changePicture)];
    self.navigationItem.rightBarButtonItem = takePictureButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
    [self initializeViews];
}

- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"EMPLOYEE BEFORE: %@",_employee);

    [_employee setValue:_employeeDescriptionTextView.text forKey:KLB_DESCRIPTION_KEY];
    
    NSData *imageData = UIImagePNGRepresentation(_employeeImage.image);
    NSString *imageString = [imageData base64EncodedStringWithOptions:0];
    [_employee setValue:imageString forKey:KLB_IMAGE_KEY];

    NSString *isTraineeValue;
    if ([_traineeSwitchValueLabel.text isEqualToString:@"YES"]) {
        isTraineeValue = @"true";
    }
    else if ([_traineeSwitchValueLabel.text isEqualToString:@"NO"]) {
        isTraineeValue = @"false";
    }
    [_employee setValue:isTraineeValue forKey:KLB_ISTRAINEE_KEY];

    [_employee setValue:_employeeNameField.text forKey:KLB_NAME_KEY];
    
    NSNumber *rating = [NSNumber numberWithFloat:_employeeRatingSlider.value];
    [_employee setValue:rating forKey:KLB_RATING_KEY];
    
    [_employee setValue:_languageButton.titleLabel.text forKey:KLB_LANGUAGE_KEY];
    
    [[KLBEmployeeStore sharedStore] setEmployeeWithDictionary:_employee section:_section index:_index];
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)revertChanges:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Revert Changes" message:@"Confirm to revert all changes." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
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
            _employeeNameField.text = @"";
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
    if (_keyboardIsShown) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hide Keyboard" message:@"Finished editing? Confirm to hide keyboard." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Hide Keyboard"]) {
        if (buttonIndex == 0) { // NO
            // do nothing
        } else if (buttonIndex == 1) { // YES
            [[self view] endEditing:YES];
        }
    } else if([alertView.title isEqualToString:@"Revert Changes"]) {
        if (buttonIndex == 0) { // NO
                                // do nothing
        } else if (buttonIndex == 1) { // YES
            _employeeImage.image = _originalImage;
            _employeeNameField.text = _originalName;
            _employeeRatingSlider.value = _originalRating;
            _ratingSliderValueLabel.text = [NSString stringWithFormat:@"%f",_originalRating];
            _employeeTraineeSwitch.on = _originalIsTrainee;
            if (_originalIsTrainee) {
                _traineeSwitchValueLabel.text = @"YES";
            } else _traineeSwitchValueLabel.text = @"NO";
            _employeeDescriptionTextView.text = _originalDescription;
            [_languageButton setTitle:_originalLanguage forState:UIControlStateNormal];
        }
    }
    [alertView release];
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
- (IBAction)nameFieldValueChanged:(id)sender {
    [self setTitle:_employeeNameField.text];
}

#pragma mark - Utilities
- (void)refreshData {
    _employee = nil;
    _employee = [[KLBEmployeeStore sharedStore] employeeWithSection:_section index:_index];
    
    NSString *empDesc = [_employee objectForKey:KLB_DESCRIPTION_KEY];
    NSString *empImageString = [_employee objectForKey:KLB_IMAGE_KEY];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:empImageString options:0];
    UIImage *empImage = [[UIImage alloc] initWithData:imageData];
    NSNumber *isTraineeNum = [_employee objectForKey:KLB_ISTRAINEE_KEY];
    bool isTrainee = [isTraineeNum boolValue];
    NSString *empName = [_employee objectForKey:KLB_NAME_KEY];
    float empRating = [[_employee objectForKey:KLB_RATING_KEY] floatValue];
    NSString *empLang = [_employee objectForKey:KLB_LANGUAGE_KEY];
    
    if (empImage) {
        _originalImage = empImage;
    } else {
        _originalImage = [UIImage imageNamed:@"defaultImage"];
    }
    
    _originalName = empName;
    _originalRating = empRating;
    _originalIsTrainee = isTrainee;
    _originalDescription = empDesc;
    _originalLanguage = empLang;
    
    [self setTitle:empName];
}

- (void) initializeViews {
    _employeeImage.image = _originalImage;
    _employeeNameField.text = _originalName;
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

- (void)setLanguageButtonText:(NSString *)str {
    [_languageButton setTitle:str forState:UIControlStateNormal];
    [_employee setValue:str forKey:KLB_LANGUAGE_KEY];
}

- (void)keyboardShown {
    _keyboardIsShown = true;
}
- (void)keyboardHidden {
    _keyboardIsShown = false;
}

- (NSString *)section {
    return _section;
}

- (int)index {
    return _index;
}

- (void) changePicture {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    _employeeImage.image = image;
    
    NSData *imageData = UIImagePNGRepresentation(_employeeImage.image);
    NSString *imageString = [imageData base64EncodedStringWithOptions:0];
    [_employee setValue:imageString forKey:KLB_IMAGE_KEY];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //picker = nil;
}

@end
