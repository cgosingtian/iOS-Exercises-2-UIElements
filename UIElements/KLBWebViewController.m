//
//  KLBWebViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/22/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBWebViewController.h"

@interface KLBWebViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *webView;

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
    NSString *requestString = @"http://www.google.com";
    
    _URL = [NSURL URLWithString:requestString];
    
    [self loadWebViewWithURL:_URL];
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
@end
