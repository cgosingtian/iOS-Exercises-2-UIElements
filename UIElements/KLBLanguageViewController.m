//
//  KLBLanguageViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/22/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBLanguageViewController.h"
#import "KLBEmployeeViewController.h"

@interface KLBLanguageViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView *pickerLanguage;
@property (retain, nonatomic) NSArray *pickerData;
@property (retain, nonatomic) NSString *initialValue;

@end

@implementation KLBLanguageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pickerData = [[NSArray alloc] initWithObjects:@"Android",@"iOS",@"PHP",@"Other", nil];//@[@"Android",@"iOS",@"PHP",@"Other"];
    }
    return self;
}

- (void) setInitialValue:(NSString *)initialValue {
    _initialValue = initialValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_initialValue) {
        NSInteger index = [_pickerData indexOfObject:_initialValue];
        [_pickerLanguage selectRow:index inComponent:0 animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_pickerLanguage release];
    [_pickerData release];
    [super dealloc];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerData objectAtIndex:row];
}
- (IBAction)doneSelecting:(id)sender {
    UINavigationController *nc = (UINavigationController *)[self presentingViewController];
    int indexVC = [[nc viewControllers] count] - 1;
    KLBEmployeeViewController *evc = (KLBEmployeeViewController *)[[nc viewControllers] objectAtIndex:indexVC];
    int index = [_pickerLanguage selectedRowInComponent:0];
    [evc setLanguageButtonText:_pickerData[index]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
    return [_pickerData count];
    else return 0;
}
@end
