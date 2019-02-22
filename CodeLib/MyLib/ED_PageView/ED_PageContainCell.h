//
//  ED_PageContainCell.h
//  CodeLib
//
//  Created by zw on 2019/2/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ED_PageContainCell : UICollectionViewCell


- (void)refreshCellWithIndexPath:(NSIndexPath *)indexPath scrollView:(UIScrollView *)scrollView;


- (CGPoint)getCurrentContentOffSet;

@end

