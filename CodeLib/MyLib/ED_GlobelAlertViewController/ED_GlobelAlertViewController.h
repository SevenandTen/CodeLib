//
//  ED_GlobelAlertViewController.h
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_GlobelAlertViewController : UIViewController


+ (ED_GlobelAlertViewController *)showWithItems:(NSArray *)items
                                    cancelItems:(NSArray *)cancleItems
                                 viewController:(UIViewController *)viewController
                                    actionBlock:(void(^)(NSInteger section , NSInteger row))actionBlock;

@end

NS_ASSUME_NONNULL_END
