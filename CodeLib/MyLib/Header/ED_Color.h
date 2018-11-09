//
//  ED_Color.h
//  CodeLib
//
//  Created by zw on 2018/11/5.
//  Copyright © 2018 seventeen. All rights reserved.
//

#ifndef ED_Color_h
#define ED_Color_h

// 颜色取值
#define ColorWithNumberRGB(_hex)  ColorWithNumberRGBA(_hex,1.f)

#define ColorWithNumberRGBA(_hex,_alpha) ColorWithRGBA(((_hex)>>16)&0xFF,((_hex)>>8)&0xFF,(_hex)&0xFF,_alpha)

#define ColorWithRGBA(int_r,int_g,int_b,_alpha)  \
[UIColor colorWithRed:(int_r)/255.0 green:(int_g)/255.0 blue:(int_b)/255.0 alpha:_alpha]


#endif /* ED_Color_h */
