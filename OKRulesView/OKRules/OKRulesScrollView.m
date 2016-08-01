//
//  OKRulesView
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import "OKRulesScrollView.h"

const CGFloat OKMinScale       = 0.0;
const CGFloat OKMaxScale       = 100000.0;
const CGFloat OKAvgScale       = 500.0;
const CGFloat OKScalePadding   = 10.0;
const CGFloat OKShowValueScale = 5000.0;

@implementation OKRulesScrollView

- (instancetype)init {
    if (self = [super init]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGMutablePathRef minScalePathRef = CGPathCreateMutable();
    CGMutablePathRef maxScalePathRef = CGPathCreateMutable();
    CGMutablePathRef linePathRef = CGPathCreateMutable();
    
    CAShapeLayer *minScaleShapeLayer = [CAShapeLayer layer];
    minScaleShapeLayer.strokeColor = OKLineColor.CGColor;
    minScaleShapeLayer.fillColor = OKLineColor.CGColor;
    minScaleShapeLayer.lineWidth = 1.f;
    minScaleShapeLayer.lineCap = kCALineCapButt;
    
    CAShapeLayer *maxScaleShapeLayer = [CAShapeLayer layer];
    maxScaleShapeLayer.strokeColor = OKLineColor.CGColor;
    maxScaleShapeLayer.fillColor = OKLineColor.CGColor;
    maxScaleShapeLayer.lineWidth = 1.f;
    maxScaleShapeLayer.lineCap = kCALineCapButt;
    
    CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
    lineShapeLayer.strokeColor = OKLineColor.CGColor;
    lineShapeLayer.fillColor = OKLineColor.CGColor;
    lineShapeLayer.lineWidth = 1.f;
    lineShapeLayer.lineCap = kCALineCapButt;
    
    // 一共的格数
    NSInteger ruleCount = (OKMaxScale - OKMinScale) / OKAvgScale;
    // 开始的距离
    CGFloat startX = rect.size.width * 0.5;
    
    for (int i = 0; i <= ruleCount; i++) {
        
        NSInteger value = i * OKAvgScale;
        
        if (value % (int)OKShowValueScale == 0) {
            
            CGPathMoveToPoint(maxScalePathRef, NULL, startX + OKScalePadding * i, rect.size.height - 15.0);
            CGPathAddLineToPoint(maxScalePathRef, NULL, startX + OKScalePadding * i, rect.size.height - 1.0);
            
            UILabel *markLabel = [[UILabel alloc] init];
            markLabel.textColor = OKLineColor;
            markLabel.text = [NSString stringWithFormat:@"%.f", i * OKAvgScale];
            markLabel.font = [UIFont boldSystemFontOfSize:12.0];
            markLabel.frame = CGRectMake(OKScalePadding * i, 0, 0, 0);
            [markLabel sizeToFit];
            markLabel.center = CGPointMake(startX + OKScalePadding * i, markLabel.center.y);
            [self addSubview:markLabel];
            
        } else {
            
            CGPathMoveToPoint(minScalePathRef, NULL, startX + OKScalePadding * i, rect.size.height - 8.0);
            CGPathAddLineToPoint(minScalePathRef, NULL, startX + OKScalePadding * i, rect.size.height - 1.0);
        }
    }
    
    minScaleShapeLayer.path = minScalePathRef;
    maxScaleShapeLayer.path = maxScalePathRef;
    CGPathRelease(minScalePathRef);
    CGPathRelease(maxScalePathRef);
    [self.layer addSublayer:minScaleShapeLayer];
    [self.layer addSublayer:maxScaleShapeLayer];
    
    // 底部长线
    CGPathMoveToPoint(linePathRef, NULL, startX, rect.size.height - 1.0);
    CGPathAddLineToPoint(linePathRef, NULL, startX + OKScalePadding * ruleCount, rect.size.height);
    lineShapeLayer.path = linePathRef;
    CGPathRelease(linePathRef);
    [self.layer addSublayer:lineShapeLayer];
    
    self.contentSize = CGSizeMake(startX * 2 + OKScalePadding * ruleCount, rect.size.height);
}

@end