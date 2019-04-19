//
//  ED_RefreshNormalHeader.h
//  CodeLib
//
//  Created by zw on 2018/11/20.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_BaseRefreshView.h"
//从原点定位的 刷新控件

@interface ED_RefreshNormalHeader : ED_BaseRefreshView

@property (nonatomic , assign) CGFloat headerHeight;


//是否从原点开始
@property (nonatomic , assign) BOOL isFromOrigin;


@property (nonatomic , assign) BOOL isSuspend;





@end


