//
//  CustomTableViewCell.m
//  weatherForecast
//
//  Created by hide on 2015/03/30.
//  Copyright (c) 2015年 堀之内英典. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)rowHeight{
    return 80.0f;
}

@end
