//
//  ED_SearchRecordView.m
//  MyCode
//
//  Created by 崎崎石 on 2018/6/12.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "ED_SearchRecordView.h"

@interface ED_LocationTapGesture : UITapGestureRecognizer

@property (nonatomic , assign) NSInteger section ;

@property (nonatomic , assign) NSInteger row;

@end

@implementation ED_LocationTapGesture


@end




@interface ED_SearchRecordView ()
@property (nonatomic , assign) CGFloat maxLength;

@property (nonatomic , assign) CGFloat lineSpace;

@property (nonatomic , assign) CGFloat itemSpace;

@property (nonatomic , assign) CGFloat itemHeight;

@property (nonatomic , assign) CGFloat currentLength;

@property (nonatomic , assign) CGFloat currentHeight;


@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSMutableArray *subViewArray;

@end

@implementation ED_SearchRecordView

- (instancetype)initWithMaxLength:(CGFloat)maxLength delegate:(id<ED_SearchRecordViewDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        _maxLength = maxLength;
        _lineSpace = 10;
        _itemSpace = 10;
        _itemHeight = 20;
        _currentHeight = 10;
        _currentLength = 10;
        [self configureView];
        
    }
    return self;
}



- (void)reloadData {
    [self updateContentViews];
}


- (void)configureView {
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self updateContentViews];
}

- (void)updateContentViews {
    if (self.subViewArray.count != 0) {
        for (UIView * subView in self.subViewArray) {
            [subView removeFromSuperview];
        }
        [self.subViewArray removeAllObjects];
    }
    _currentHeight = 10;
    _currentLength = 10;
    NSArray *titlteArray = [self.delegate searchRecordViewTitleDataSource:self];
    if (titlteArray.count == 0) {
        return;
    }
    for (NSInteger i = 0 ; i < titlteArray.count; i ++) {
        NSString *title = [titlteArray objectAtIndex:i];
        UILabel *titleLabel = [self createTitleLabelWithTitle:title];
        [self.scrollView addSubview:titleLabel];
        if (i != 0) {
            _currentHeight = _currentHeight + _lineSpace +_itemHeight;
        }
        _currentLength = 10;
        CGFloat width = [self calculateSizeWithText:title fontNumber:12 width:MAXFLOAT].width;
        titleLabel.frame = CGRectMake(_currentLength, _currentHeight, width, _itemHeight);
        _currentHeight = _currentHeight + _lineSpace +_itemHeight;
        [self.subViewArray addObject:titleLabel];
        NSArray *itemArray = [self.delegate searchRecordView:self itemDataSourceWithLocation:i];
        if (itemArray.count != 0) {
            for (NSInteger j = 0; j < itemArray.count ; j ++) {
                NSString *itemTitle = [itemArray objectAtIndex:j];
                CGFloat itemWidth = [self calculateSizeWithText:itemTitle fontNumber:12 width:MAXFLOAT].width + 10;
                if (itemWidth >= _maxLength/2.0) {
                    itemWidth = _maxLength/2.0;
                }
                UILabel *itemLabel = [self createContentLabelWithSection:i row:j title:itemTitle];
                [self.scrollView addSubview:itemLabel];
                if (itemWidth <= _maxLength - _currentLength) {
                    itemLabel.frame = CGRectMake(_currentLength, _currentHeight, itemWidth, _itemHeight);
                    _currentLength = _currentLength + itemWidth + _itemSpace;
                }else{
                    _currentLength = 10 ;
                    _currentHeight = _currentHeight + _lineSpace +_itemHeight;
                    itemLabel.frame = CGRectMake(_currentLength, _currentHeight, itemWidth, _itemHeight);
                }
                
                [self.subViewArray addObject:itemLabel];
            }
        }
        
    }
    self.scrollView.contentSize = CGSizeMake(_maxLength, _currentHeight);
    
}



#pragma mark - Private

- (UILabel *)createTitleLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    int a = 0x8e8e93;
    label.textColor = [UIColor colorWithRed:((a >> 16) &0xff)/255.0 green:((a >> 8) &0xff)/255.0  blue:(a&0xff)/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (UILabel *)createContentLabelWithSection:(NSInteger )section row:(NSInteger )row title:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
     int a = 0x666666;
    label.textColor = [UIColor colorWithRed:((a >> 16) &0xff)/255.0 green:((a >> 8) &0xff)/255.0  blue:(a&0xff)/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    int b = 0xf0f0f2;
    label.backgroundColor = [UIColor colorWithRed:((b >> 16) &0xff)/255.0 green:((b >> 8) &0xff)/255.0  blue:(b&0xff)/255.0 alpha:1.0];;
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 2.0f;
    ED_LocationTapGesture *tapGesture = [[ED_LocationTapGesture alloc] initWithTarget:self action:@selector(contentItemViewDidClick:)];
    tapGesture.section = section;
    tapGesture.row = row;
    [label addGestureRecognizer:tapGesture];
    
    return label;
}

#pragma mark - Action

- (void)contentItemViewDidClick:(ED_LocationTapGesture *)tap {
    [self.delegate searchRecordView:self didClickItemWithSection:tap.section row:tap.row];
    
}


#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView .contentSize = CGSizeZero;
    }
    return _scrollView;
}

- (NSMutableArray *)subViewArray {
    if (!_subViewArray) {
        _subViewArray = [[NSMutableArray alloc] init];
    }
    return _subViewArray;
}




#pragma mark -


- (CGSize)calculateSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
    return [self calculateSizeWithAttributeText:attributedText font:font width:width];
}

- (CGSize)calculateSizeWithText:(NSString *)text fontNumber:(NSInteger)fontNumber width:(CGFloat)width {
    UIFont *font = [UIFont systemFontOfSize:fontNumber];
    return [self calculateSizeWithText:text font:font width:width];
}


- (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText font:(UIFont *)font width:(CGFloat)width {
    if (attributedText.length == 0) {
        return CGSizeZero;
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = attributedText;
    CGSize intrinsicContentSize = [label intrinsicContentSize];
    
    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));
}

- (CGSize)calculateSizeWithAttributeText:(NSAttributedString *)attributedText fontNumber:(NSInteger)fontNumber width:(CGFloat)width {
    UIFont *font = [UIFont systemFontOfSize:fontNumber];
    return [self calculateSizeWithAttributeText:attributedText font:font width:width];
    
}




@end
