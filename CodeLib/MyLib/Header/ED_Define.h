//
//  ED_Define.h
//  CodeLib
//
//  Created by zw on 2018/11/20.
//  Copyright © 2018 seventeen. All rights reserved.
//

#ifndef ED_Define_h
#define ED_Define_h

// 颜色取值
#define ColorWithNumberRGB(_hex)  ColorWithNumberRGBA(_hex,1.f)

#define ColorWithNumberRGBA(_hex,_alpha) ColorWithRGBA(((_hex)>>16)&0xFF,((_hex)>>8)&0xFF,(_hex)&0xFF,_alpha)

#define ColorWithRGBA(int_r,int_g,int_b,_alpha)  \
[UIColor colorWithRed:(int_r)/255.0 green:(int_g)/255.0 blue:(int_b)/255.0 alpha:_alpha]



//NSLog
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



#define ImgName(_hex)  [UIImage imageNamed:_hex]

//字体
#define Font(_hex) [UIFont systemFontOfSize:_hex]


#endif /* ED_Define_h */
