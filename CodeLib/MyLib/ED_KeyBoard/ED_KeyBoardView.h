//
//  ED_KeyBoardView.h
//  CodeLib
//
//  Created by zw on 2019/11/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger ,ED_KeyBoardType) {
    ED_KeyBoardCity,
    ED_KeyBoardArea,
    ED_KeyBoardNumber,
};

@class ED_KeyBoardView;

@protocol  ED_KeyBoardViewDelegate<NSObject>

- (void)keyboard:(ED_KeyBoardView *)keyBoardView didInputText:(NSString *)text;


@end


@interface ED_KeyBoardView : UIView


- (instancetype)initWithKeyBoardType:(ED_KeyBoardType)type;

@property (nonatomic , weak) id<ED_KeyBoardViewDelegate>delegate;


- (void)setBtnStatusWithFlag:(BOOL)flag fromBeginIndex:(NSInteger)beginIndex toEndIndex:(NSInteger)endIndex;

- (void)setBtnStatusWithFlag:(BOOL)flag index:(NSInteger)index;

- (void)setLastBtnStatusWithFlag:(BOOL)flag;

@end


