//
//  BaseTableViewCell.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/15.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



@interface BaseTableViewCell : UITableViewCell


+ (id)configCellWithTableView:(UITableView *)tableView;
//子类重写这个初始化方法即可
- (id)initWithCellReuse:(NSString *)cellReuse;

@end
