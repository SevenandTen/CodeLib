//
//  ED_ProgressView.h
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_ProgressView : UIView


- (void)startRecordTimeActionBlock:(void(^)(void))actionBlock;


- (void)stopRecordTime;

@end

NS_ASSUME_NONNULL_END
