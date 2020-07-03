//
//  ED_TakePhotoView.h
//  CodeLib
//
//  Created by zw on 2020/1/14.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ED_TakePhotoView;
@protocol ED_TakePhotoViewDelegate <NSObject>

- (void)takePhotoView:(ED_TakePhotoView *)takePhoto didClickTakePhoto:(UIImage *)image;

@end




@interface ED_TakePhotoView : UIView

@property (nonatomic , weak) id<ED_TakePhotoViewDelegate>delegate;

@end


