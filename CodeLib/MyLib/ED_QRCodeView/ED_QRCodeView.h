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

@optional

- (void)QRCodeView:(ED_QRCodeView *)codeView didReceviceCode:(NSString *)code;


@end


@interface ED_QRCodeView : UIView


@property (nonatomic , assign) BOOL flag; // 是否接受扫码结果

@property (nonatomic , weak) id<ED_QRCodeViewDelegate>delegate;



@end


