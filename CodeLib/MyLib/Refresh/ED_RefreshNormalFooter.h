//
//  ED_RefreshNormalFooter.h
//  CodeLib
//
//  Created by zw on 2018/11/21.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_BaseRefreshView.h"



@interface ED_RefreshNormalFooter : ED_BaseRefreshView

@property (nonatomic , assign) CGFloat footerHeight;


//是否算入额外的 inset
@property (nonatomic , assign) BOOL isFromLast;

@end


