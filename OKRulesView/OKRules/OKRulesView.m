//
//  OKRulesView
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "OKRulesView.h"
#import "OKRulesScrollView.h"

@interface OKRulesView () <UIScrollViewDelegate>

@property (nonatomic, strong) OKRulesScrollView *rulesScrollView;

@end

@implementation OKRulesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCommonUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupCommonUI];
    }
    return self;
}

- (void)setupCommonUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _rulesScrollView = [[OKRulesScrollView alloc] init];
    _rulesScrollView.backgroundColor = [UIColor whiteColor];
    _rulesScrollView.delegate = self;
    _rulesScrollView.bounces = NO;
    [self addSubview:_rulesScrollView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _rulesScrollView.frame = self.bounds;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pointValue = OKAvgScale / OKScalePadding;
    if (_currentValueBlock) {
        self.currentValueBlock(scrollView.contentOffset.x * pointValue);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self __animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self __animationRebound:scrollView];
}

- (void)__animationRebound:(UIScrollView *)scrollView {
    
    NSInteger quot = scrollView.contentOffset.x / OKScalePadding;
    NSInteger remainder = (int)scrollView.contentOffset.x % (int)OKScalePadding;
    
    CGFloat offX = 0.0;
    if (remainder < OKScalePadding * 0.5) {
        offX = quot * OKScalePadding;
    } else {
        offX = (quot + 1) * OKScalePadding;
    }
    
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}

- (void)drawRect:(CGRect)rect {
  
    // 红色指示器
    CAShapeLayer *pointShapeLayer = [CAShapeLayer layer];
    pointShapeLayer.strokeColor = OKPointColor.CGColor;
    pointShapeLayer.fillColor = OKPointColor.CGColor;
    
    CGMutablePathRef pointPathRef = CGPathCreateMutable();
    CGPathAddEllipseInRect(pointPathRef, NULL, CGRectMake(rect.size.width * 0.5 - 3.5, rect.size.height - 15 - 7, 7, 7));
    pointShapeLayer.path = pointPathRef;
    CGPathRelease(pointPathRef);
    
    [self.layer addSublayer:pointShapeLayer];
    
    CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
    lineShapeLayer.lineWidth = 1.0;
    lineShapeLayer.fillColor = OKPointColor.CGColor;
    lineShapeLayer.strokeColor = OKPointColor.CGColor;
    lineShapeLayer.lineCap = kCALineCapButt;
    
    CGMutablePathRef linePathRef = CGPathCreateMutable();
    CGPathMoveToPoint(linePathRef, NULL, rect.size.width * 0.5, rect.size.height - 15);
    CGPathAddLineToPoint(linePathRef, NULL, rect.size.width * 0.5, rect.size.height);
    
    lineShapeLayer.path = linePathRef;
    CGPathRelease(linePathRef);
    [self.layer addSublayer:lineShapeLayer];
}

@end
