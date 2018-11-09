//
//  ED_LocationManager.h
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ED_LocationManager : NSObject

@property (nonatomic,strong,readonly) NSString *latitude;

@property (nonatomic,strong,readonly) NSString *longitude;

@property (nonatomic,strong) NSString *cityName;


+ (instancetype)shareInstance;


- (void)startLocation;

@end


