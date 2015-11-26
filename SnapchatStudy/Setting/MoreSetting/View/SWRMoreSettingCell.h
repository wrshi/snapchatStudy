//
//  SWRMoreSettingCell.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWRMoreSettingCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

+ (instancetype)SWRMoreSettingCellWithTableView:(UITableView *)tableView;

@end
