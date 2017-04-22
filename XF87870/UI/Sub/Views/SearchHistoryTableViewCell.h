//
//  SearcHistoryTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/11/28.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchHistoryTableViewCellProtocol<NSObject>

- (void) deleteIndividulSearchHitoryByIndex:(NSInteger)index;

- (void) searchHistoryLabelTappedByIndex:(NSInteger)index;

@end

@interface SearchHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *searchHistoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchHistoryButton;
@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) id<SearchHistoryTableViewCellProtocol> delegate;
@end
