//
//  ViewController.h
//  weatherForecast
//
//  Created by 堀之内英典 on 2015/03/30.
//  Copyright (c) 2015年 堀之内英典. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

