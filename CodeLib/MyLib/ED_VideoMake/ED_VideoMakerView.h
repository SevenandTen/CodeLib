//
//  ED_VideoMakerView.h
//  CodeLib
//
//  Created by zw on 2019/10/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ED_VideoMakerView;
@protocol ED_VideoMakerViewDelegate <NSObject>

- (void)videoMakerView:(ED_VideoMakerView *)videoView didGetVideoUrl:(NSURL *)videoUrl;

@end


@interface ED_VideoMakerView : UIView

@end


