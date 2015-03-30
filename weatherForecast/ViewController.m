//
//  ViewController.m
//  weatherForecast
//
//  Created by 堀之内英典 on 2015/03/30.
//  Copyright (c) 2015年 堀之内英典. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "TableViewConst.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@end

@implementation ViewController{
    NSArray *weatherArray;
    NSMutableArray *dayArray;
    NSMutableArray *maxTemp;
    NSMutableArray *minTemp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //カスタマイズセルをtableviewにセット
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    //現在日付をラベル表示
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd EEE";
    self.timeLabel.text = [dateFormatter stringFromDate:nowDate];
    
    //天気予報情報を取得
    NSURL *url = [NSURL URLWithString:@"http://openweathermap.org/data/2.5/forecast/daily?q=Tokyo&mode=json&units=metric&cnt=7"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error = nil;
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    weatherArray = [jsonObj valueForKeyPath:@"list"];
    
    //（週間予報用）曜日を取得
    dayArray = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        NSTimeInterval unixTime = [[jsonObj valueForKeyPath:@"list.dt"][i] doubleValue];
        NSDate *correctData = [NSDate dateWithTimeIntervalSince1970:unixTime];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE"];
        NSString *dateStr = [dateFormatter stringFromDate:correctData];
        [dayArray addObject:dateStr];
    }
    
    //（週間予報用）気温を取得
    maxTemp = [[NSMutableArray alloc]init];
    minTemp = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        NSNumber *maxTempNum = [jsonObj valueForKeyPath:@"list.temp.max"][i];
        NSString *maxTempStr = [NSString stringWithFormat:@"%ld",(long)[maxTempNum integerValue]];
        NSNumber *minTempNum = [jsonObj valueForKeyPath:@"list.temp.min"][i];
        NSString *minTempStr = [NSString stringWithFormat:@"%ld",(long)[minTempNum integerValue]];
        [maxTemp addObject:maxTempStr];//最高気温
        [minTemp addObject:minTempStr];//最低気温
    }
    
}

//表示する行数を設定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

//cellに表示する内容を設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.dayLabel.text = [NSString stringWithFormat:@"%@day",[dayArray objectAtIndex:indexPath.row]];//曜日を表示
    cell.maxTempLabel.text = [NSString stringWithFormat:@"%@℃",[maxTemp objectAtIndex:indexPath.row]];//最高気温を表示
    cell.minTempLabel.text = [NSString stringWithFormat:@"%@℃",[minTemp objectAtIndex:indexPath.row]];//最低気温を表示
    return cell;
}

//セルの高さを返す
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [CustomTableViewCell rowHeight];
}

//tableviewとcellの背景を透明にする。
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
