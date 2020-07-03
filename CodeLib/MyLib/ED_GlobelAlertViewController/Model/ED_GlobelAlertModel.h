//
//  ED_GlobelAlertModel.h
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ED_GlobelAlertModel : NSObject

@property (nonatomic , strong) UIColor *textColor;

@property (nonatomic , strong) UIFont *font;

@property (nonatomic , strong) NSString *text;

@property (nonatomic , strong) NSAttributedString *attributeText;


+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color attributeText:(NSAttributedString *)attributeText;

+ (instancetype)modelWithAttributeText:(NSAttributedString *)attributeText;

+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color;

+ (instancetype)modelWithText:(NSString *)text textColor:(UIColor *)color;

+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text;

+ (instancetype)modelWithText:(NSString *)text;





- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color attributeText:(NSAttributedString *)attributeText;

- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color ;

- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text;

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor;

- (instancetype)initWithAttributeText:(NSAttributedString *)attributeText;



@end


