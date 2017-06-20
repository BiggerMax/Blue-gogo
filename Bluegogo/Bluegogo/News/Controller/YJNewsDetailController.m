//
//  YJNewsDetailController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJNewsDetailController.h"

@interface YJNewsDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIView *lodingView;
@end

@implementation YJNewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
	[self.view addSubview:self.lodingView];
	UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
	myWebView.delegate = self;
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
	[myWebView loadRequest:request];
	[self.view insertSubview:myWebView atIndex:0];
	self.webView = myWebView;
	
}
-(void)initUI{
	UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
	loadingView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
	UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
	backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
	[backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
	backBtn.titleLabel.textColor = [UIColor blackColor];
	backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
	backBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
	backBtn.layer.cornerRadius = 15;
	backBtn.layer.masksToBounds = YES;
	[loadingView addSubview:backBtn];
	[backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
	
	UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH /2 - 50, 200, 100, 100)];
	[logo setImage:[UIImage imageNamed:@"logo.png"]];
	[loadingView addSubview:logo];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.fromValue = [NSNumber numberWithFloat:1.0f];
	animation.toValue = [NSNumber numberWithFloat:0.0f];
	animation.autoreverses = YES;
	animation.duration = 0.5f;
	animation.repeatCount = MAXFLOAT;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[logo.layer addAnimation:animation  forKey:@"aAlpha"];
	
	UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, SCREENWIDTH, 20)];
	tips.textColor = NAVBLUECOLOR;
	tips.text = @"加载中...";
	tips.textAlignment = NSTextAlignmentCenter;
	tips.font = [UIFont systemFontOfSize:20.0];
	[loadingView addSubview:tips];
	self.lodingView = loadingView;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.lodingView removeFromSuperview];
	});
}
-(void)backClick{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
