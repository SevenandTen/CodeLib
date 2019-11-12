//
//  ED_QRCodeView.h
//  CodeLib
//
//  Created by zw on 2019/9/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ED_QRCodeView;


@protocol ED_QRCodeViewDelegate <NSObject>

- (void)codeView:(ED_QRCodeView *)codeView didReceiveCodeString:(NSString *)code isSuccess:(BOOL)isSuccess;

@end


@interface ED_QRCodeView : UIView


@property (nonatomic , assign) CGFloat spaceWidth ; // 距离屏幕左右多少距离

@property (nonatomic , assign) CGFloat spaceHeight; // 距离屏幕中心多少

@property (nonatomic , weak) id <ED_QRCodeViewDelegate> delegate;




- (void)startRuning; // vc will appear

- (void)stopRuning; // vc will disapper

- (void)continueRuning; // delegate  countinue next code


@end


