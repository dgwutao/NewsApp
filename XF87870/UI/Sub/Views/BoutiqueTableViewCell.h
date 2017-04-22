//
//  BouquiteTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BoutiqueTableViewCellProtocol <NSObject>

- (void) showBoutiqueDetail:(NSInteger)index;

@end

@interface BoutiqueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *showDetailButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) id<BoutiqueTableViewCellProtocol> delegate;
@end
