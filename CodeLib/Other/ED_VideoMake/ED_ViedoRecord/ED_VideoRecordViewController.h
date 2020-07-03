//
//  ED_VideoRecordViewController.h
//  CodeLib
//
//  Created by zw on 2020/1/2.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ED_VideoRecordViewController : UIViewController

@property (nonatomic , copy) void(^actionBlock)(NSURL *url);


+ (ED_VideoRecordViewController *)showWithViewController:(UIViewController *)viewController actionBlock:(void(^)(NSURL *url))actionBlock;

@end


