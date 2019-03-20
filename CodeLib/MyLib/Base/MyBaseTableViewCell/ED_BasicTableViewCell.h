//
//  ED_BasicTabelViewCell.h
//  CodeLib
//
//  Created by zw on 2018/11/5.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger , ED_BasicTabelViewCellShowType) {
    ED_BasicTabelViewCellSelected = 1,
    ED_BasicTabelViewCellHighted,
    ED_BasicTabelViewCellNone,
};



@interface ED_BasicTableViewCell : UITableViewCell

//选中颜色
@property (nonatomic , strong) UIColor *selectedColor;

@property (nonatomic , strong) UIColor *lineColor;

@property (nonatomic , assign) CGFloat lineWidth;

@property (nonatomic , assign) UIEdgeInsets lineInset;

@property (nonatomic , assign) ED_BasicTabelViewCellShowType showType;

- (UIView *)selectionView;

@end

