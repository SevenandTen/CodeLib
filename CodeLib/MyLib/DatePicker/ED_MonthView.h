//
//  ED_MonthView.h
//  CodeLib
//
//  Created by zw on 2018/12/12.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ED_MonthView;
@protocol ED_MonthViewDelegate <NSObject>

- (void)monthView:(ED_MonthView *)view didScrollYears:(NSInteger)years isYearIncrease:(BOOL)isYearIncrease lastMonth:(NSInteger)lastMonth currentMonth:(NSInteger)currentMonth;

@end

@interface ED_MonthView : UIView

@property (nonatomic , assign) CGFloat itemWidth;

- (void)setBeginMonth:(NSInteger)month;

@property (nonatomic , weak) id<ED_MonthViewDelegate>delegate;


@end


