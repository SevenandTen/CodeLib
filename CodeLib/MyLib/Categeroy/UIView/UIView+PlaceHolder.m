//
//  UIView+PlaceHolder.m
//  MyCode
//
//  Created by 崎崎石 on 2018/5/25.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "UIView+PlaceHolder.h"

@implementation UIView (PlaceHolder)

- (void)changePlaceHolderFont:(UIFont *)font {
    [self changePlaceHolder:nil color:nil font:font];
}

- (void)changePlaceHolderWithFontNumber:(NSInteger)fontNumber {
    [self changePlaceHolder:nil color:nil font:[UIFont systemFontOfSize:fontNumber]];
}


- (void)changePlaceHolderColor:(UIColor *)color {
    [self changePlaceHolderColor:color];
}



- (void)changePlaceHolder:(NSString *)placeHolder color:(UIColor *)color font:(UIFont *)font {
    
    if ([self isKindOfClass:[UISearchBar class]]) {
        UITextField *textfield = [self valueForKey:@"_searchField"];
        textfield.font = [UIFont systemFontOfSize:13];
        if (placeHolder.length != 0 ) {
            textfield.placeholder = placeHolder;
        }
        if (color) {
            [textfield setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        }
        if (font) {
            [textfield setValue:font forKeyPath:@"_placeholderLabel.font"];
        }
        
        
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *textfield =  (UITextField *)self;
        if (placeHolder.length != 0 ) {
            textfield.placeholder = placeHolder;
        }
        if (color) {
            [textfield setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        }
        if (font) {
            [textfield setValue:font forKeyPath:@"_placeholderLabel.font"];
        }
    }else {
        return;
    }
}

@end
