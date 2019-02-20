//
//  ED_PageView.h
//  CodeLib
//
//  Created by zw on 2019/2/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ED_PageViewDelegate <NSObject>



@end


@interface ED_PageView : UIView


@property (nonatomic , weak) id<ED_PageViewDelegate>delegate;

@end


