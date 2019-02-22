//
//  ED_PageContext.h
//  CodeLib
//
//  Created by zw on 2019/2/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// page上下文路径

@interface ED_PageContextManager : NSObject

@property (nonatomic , assign) CGPoint lastPoint;

@property (nonatomic , readonly) NSArray *dataSource;

@property (nonatomic , assign) CGFloat zeroHeight;

@property (nonatomic , strong) UIColor *lineColor;

@property (nonatomic , readonly) CGFloat fontNumber;

@property (nonatomic , strong) UIColor *normalColor;

@property (nonatomic , strong) UIColor *seletColor;

@property (nonatomic , weak) id  delegate;

@property (nonatomic , assign) CGFloat titleHeight;

@property (nonatomic , readonly) CGFloat totalWidth;

@property (nonatomic , assign) CGFloat minSpace;


@property (nonatomic , assign) NSInteger currentIndex;

@property (nonatomic , assign) CGFloat itemWidth;

@property (nonatomic , assign) CGFloat lineWidth;


@property (nonatomic , assign) CGFloat style ; // 默认是0 表示使用tableView  1 表示collectionView;



+ (instancetype)shareIntance;


- (void)fillWithTitleArray:(NSArray<NSString *> *)titleArray fontNumber:(CGFloat)fontNumber;




@end





@interface ED_PageContext : NSObject

@property (nonatomic , assign) CGPoint lastPoint;

@property (nonatomic , strong) NSString *title;

@property (nonatomic , readonly) CGFloat width;

@property (nonatomic , assign) CGPoint contentOffSet;

@property (nonatomic , assign) CGFloat fontNumber;

@property (nonatomic , weak) id delegate;


- (instancetype)initWithTitle:(NSString *)title fontNumber:(CGFloat)fontNumber;

@end


