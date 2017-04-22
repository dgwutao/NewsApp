//
//  BouquiteTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BoutiqueTableViewCell.h"

@implementation BoutiqueTableViewCell

- (IBAction)showDetailButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showBoutiqueDetail:)]) {
        [self.delegate showBoutiqueDetail:self.index];
    }
}

@end
