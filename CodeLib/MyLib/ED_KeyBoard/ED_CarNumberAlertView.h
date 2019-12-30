//
//  ED_CarNumberAlertView.h
//  CodeLib
//
//  Created by zw on 2019/12/30.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ED_KeyBoardInputType) {
    ED_KeyBoardInputCity,
    ED_KeyBoardInputNumber
};



@class ED_KeyBoardInputView;

@protocol  ED_KeyBoardInputViewDelegate<NSObject>

- (void)keyboard:(ED_KeyBoardInputView *)keyBoardView didInputText:(NSString *)text;


@end



@interface ED_KeyBoardInputView : UIView



@property (nonatomic , weak) id<ED_KeyBoardInputViewDelegate>delegate;


- (void)setBtnStatusWithFlag:(BOOL)flag fromBeginIndex:(NSInteger)beginIndex toEndIndex:(NSInteger)endIndex;

- (void)setBtnStatusWithFlag:(BOOL)flag index:(NSInteger)index;

- (void)setLastBtnStatusWithFlag:(BOOL)flag;


- (instancetype)initWithKeyBoardType:(ED_KeyBoardInputType)type;

@end





@interface ED_CarNumberAlertView : UIView


+ (ED_CarNumberAlertView *)showWithCarNumber:(NSString *)carNumber anmation:(BOOL)anmation actionBlock:(void(^)(NSString * plateNumber)) actionBlock;


@end






