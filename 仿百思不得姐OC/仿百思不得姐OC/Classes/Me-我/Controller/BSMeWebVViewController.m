//
//  BSMeWebVViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/15.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSMeWebVViewController.h"

@interface BSMeWebVViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwordButton;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation BSMeWebVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.webView setBackgroundColor:[UIColor grayColor]];
    [self.webView setDelegate:self];

    self.navigationItem.title = self.name;
}




- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)refreshButton:(UIBarButtonItem *)sender {
    [self.webView reload];
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}


#pragma mark - webview Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backButton.enabled = self.webView.canGoBack;
    self.forwordButton.enabled = self.webView.canGoForward;

}
/*


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
