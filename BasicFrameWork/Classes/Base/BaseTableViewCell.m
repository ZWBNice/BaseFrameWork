//
//  BaseTableViewCell.m
//  ProjectFramework
//
//  Created by zwb on 2018/1/15.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell


+ (NSString *)cellReuse{
    return NSStringFromClass([self class]);
}

+ (id)configCellWithTableView:(UITableView *)tableView{
    NSString *cellReuse = [self cellReuse];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellReuse];
    
    if (cell==nil) {
        cell = [[self alloc] initWithCellReuse:cellReuse];
    }
    return cell;
}

- (id)initWithCellReuse:(NSString *)cellReuse{
    UITableViewCell *cell = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuse];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return (id)cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
