//
//  ED_GlobelAlertCell.h
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_GlobelAlertCell : UITableViewCell


- (void)setLineColor:(UIColor *)lineColor;

- (void)refreshCellWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
