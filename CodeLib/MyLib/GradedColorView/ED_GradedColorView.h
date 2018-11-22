//
//  ED_GradedColorView.h
//  CodeLib
//
//  Created by zw on 2018/11/21.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ED_GradedColorView : UIView

@property (nonatomic , strong) NSArray<UIColor *>* colors;

@property (nonatomic , assign) CGPoint startPoint;

@property (nonatomic , assign) CGPoint endPoint;

@property (nonatomic , strong) NSArray<NSNumber*>* locations;

@end


