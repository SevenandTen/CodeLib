//
//  ED_SearchRecordView.h
//  MyCode
//
//  Created by 崎崎石 on 2018/6/12.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ED_SearchRecordView;
@protocol ED_SearchRecordViewDelegate<NSObject>

@required
- (NSArray<NSString *> *)searchRecordViewTitleDataSource:(ED_SearchRecordView *)searchView;

- (NSArray<NSString *> *)searchRecordView:(ED_SearchRecordView *)searchRecordView itemDataSourceWithLocation:(NSInteger) location;


@optional

- (void)searchRecordView:(ED_SearchRecordView *)searchRecordView didClickItemWithSection:(NSInteger)section row:(NSInteger)row;

@end
@interface ED_SearchRecordView : UIView

- (instancetype)initWithMaxLength:(CGFloat)maxLength
                         delegate:(id<ED_SearchRecordViewDelegate>)delegate;

@property (nonatomic , weak) id<ED_SearchRecordViewDelegate>delegate;

- (void)reloadData;

@end
