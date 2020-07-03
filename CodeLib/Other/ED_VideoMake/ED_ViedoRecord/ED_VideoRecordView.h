//
//  ED_VideoRecordView.h
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ED_VideoRecordView;
@protocol ED_VideoRecordViewDelegate <NSObject>

- (void)recordView:(ED_VideoRecordView *)view didFinishWithUrl:(NSURL *)fileUrl;

@end

@interface ED_VideoRecordView : UIView

@property (nonatomic , weak) id<ED_VideoRecordViewDelegate>delegate;

@end


