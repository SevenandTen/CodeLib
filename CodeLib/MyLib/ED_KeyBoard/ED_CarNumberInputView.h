//
//  ED_CarNumberInputView.h
//  CodeLib
//
//  Created by zw on 2019/12/6.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ED_CarNumberInputView;
@protocol ED_CarNumberInputViewDelegate <NSObject>


- (void)carNumberView:(ED_CarNumberInputView *)view didClickSureWithCarNumber:(NSString *)carNumber;


@end

@interface ED_CarNumberInputView : UIView

@property (nonatomic , weak) id<ED_CarNumberInputViewDelegate> delegate;

@end


