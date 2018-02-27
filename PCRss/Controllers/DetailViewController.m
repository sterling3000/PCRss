//
//  DetailViewController.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSURL     *link;
@property (nonatomic, strong) WKWebView *webView;

@end


@implementation DetailViewController

@dynamic title;

- (id)initWithLink: (NSURL *)link title: (NSString *)title {
    self = [super init];
    if (self) {
        self.link = link;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [_webView loadRequest:[NSURLRequest requestWithURL:self.link]];
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
