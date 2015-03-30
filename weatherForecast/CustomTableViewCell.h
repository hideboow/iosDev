//
//  CustomTableViewCell.h
//  weatherForecast
//
//  Created by hide on 2015/03/30.
//  Copyright (c) 2015年 堀之内英典. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;

+(CGFloat)rowHeight;

@end
