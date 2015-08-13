//
//  ContentViewController.m
//  QHNavSliderMenuView
//
//  Created by imqiuhang on 15/8/12.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "ContentViewController.h"
#import "UIView+QHUIViewCtg.h"
@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

}

- (void)initView {
    self.view.backgroundColor = QHRGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
    
    UILabel *lable      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, QHScreenWidth  , 200)];
    lable.centerY       = self.view.height/2.f-50;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font          = defaultFont(100);
    lable.text          = [NSString stringWithFormat:@"%i",self.index];
    lable.textColor     = [UIColor whiteColor];
    [self.view addSubview:lable];
}

@end
