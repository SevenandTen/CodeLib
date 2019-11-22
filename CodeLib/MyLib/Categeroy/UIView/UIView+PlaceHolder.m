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
    [self changePlaceHolder:nil color:color font:nil];
}



- (void)changePlaceHolder:(NSString *)placeHolder color:(UIColor *)color font:(UIFont *)font {
    
    if ([self isKindOfClass:[UISearchBar class]]) {
        UITextField *textfield = nil;
        if (@available(iOS 13.0, *)) {
            UISearchBar *searchBar = (UISearchBar *)self;
            textfield = searchBar.searchTextField;
        }else {
            textfield = [self valueForKey:@"_searchField"];
        }
        if (placeHolder.length == 0) {
            placeHolder = textfield.placeholder;
            if (!placeHolder) {
                placeHolder = @"";
            }
        }
        if (!font) {
            font = textfield.font;
        }
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:font forKey:NSFontAttributeName];
        if (color) {
            [param setValue:color forKey:NSForegroundColorAttributeName];
        }
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:param];
        
        
        
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *textfield =  (UITextField *)self;
       if (placeHolder.length == 0) {
            placeHolder = textfield.placeholder;
           if (!placeHolder) {
               placeHolder = @"";
           }
        }
        if (!font) {
            font = textfield.font;
        }
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:font forKey:NSFontAttributeName];
        if (color) {
            [param setValue:color forKey:NSForegroundColorAttributeName];
        }
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:param];
    }else {
        return;
    }
}

@end
