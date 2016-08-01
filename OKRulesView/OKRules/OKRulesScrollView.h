//
//  OKRulesView
//
//  Copyright © 2016年 OK Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 最小刻度值
UIKIT_EXTERN const CGFloat OKMinScale;
/// 最大刻度值
UIKIT_EXTERN const CGFloat OKMaxScale;
/// 每个刻度值
UIKIT_EXTERN const CGFloat OKAvgScale;
/// 刻度之间的间距
UIKIT_EXTERN const CGFloat OKScalePadding;
/// 间隔刻度显示
UIKIT_EXTERN const CGFloat OKShowValueScale;

/// 游标颜色
#define OKPointColor [UIColor redColor]
/// 刻度线颜色
#define OKLineColor [UIColor blackColor]

@interface OKRulesScrollView : UIScrollView

@end
