//
//  KLBWebViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/22/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBWebViewController.h"

@interface KLBWebViewController () <UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic) void (^loadURLWithBlock)(NSURL *URL);

@end

@implementation KLBWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}

- (void) loadWebViewWithURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL)
    {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:_URL];
        [_webView loadRequest:req];
    }
}

#pragma mark - Button Actions
- (IBAction)loadWithBlock:(id)sender {
    NSString *requestString = @"https://sites.google.com/a/klab.com/ph_intra/";
    
    _URL = [NSURL URLWithString:requestString];
    
    _loadURLWithBlock = ^(NSURL *URL) {
        _URL = URL;
        if (_URL)
        {
            NSURLRequest *req = [[NSURLRequest alloc] initWithURL:_URL];
            [_webView loadRequest:req];
        }
    };
    
    _loadURLWithBlock(_URL);
}
- (IBAction)loadNormally:(id)sender {
    NSString *requestString = @"https://sites.google.com/a/klab.com/ph_intra/";
    
    _URL = [NSURL URLWithString:requestString];
    
    [self loadWebViewWithURL:_URL];
}


#pragma mark - UIWebViewDelegate Protocol
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Load Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [errorAlert show];
}
@end
