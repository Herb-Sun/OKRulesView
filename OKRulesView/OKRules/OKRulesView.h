//
//  OKRulesView
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OKRulesView : UIView

@property (nonatomic, assign) CGFloat currentValue;

@property (nonatomic, copy) void(^currentValueBlock)(CGFloat);

@end
