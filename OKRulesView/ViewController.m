//
//  ViewController.m
//  OKRulesView
//
//  Created by SHB on 16/7/30.
//  Copyright © 2016年 Herb. All rights reserved.
//

#import "ViewController.h"
#import "OKRulesView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet OKRulesView *rulesView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rulesView.currentValueBlock = ^(CGFloat value) {
        self.valueLabel.text = [NSString stringWithFormat:@"%.f", value];
    };
}

@end
