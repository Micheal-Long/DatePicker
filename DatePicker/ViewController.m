//
//  ViewController.m
//  DatePicker
//
//  Created by Micheal on 2016/11/24.
//  Copyright © 2016年 Micheal. All rights reserved.
//

#import "ViewController.h"
#import "WPDateTimePickerView.h"

@interface ViewController ()

@property(strong,nonatomic)WPDateTimePickerView *startDatePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  年月日时分
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [dateFormatter dateFromString:@"2016-11-24"];
    //  开始日期选择器
    WPDateTimePickerView *startPicker = [[WPDateTimePickerView alloc] initWithFrame:CGRectMake(0.0, (self.view.frame.size.height-140.0)/2.0, self.view.frame.size.width, 140.0) withDate:nowDate];
    startPicker.backgroundColor = [UIColor clearColor];
    startPicker.date = nowDate;
    startPicker.clickDateTimePicker = ^(NSDate *date){
        //  回收键盘
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        //  年月日时分
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //  年月日
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *string_date = [dateFormatter stringFromDate:date];
        NSLog(@"选中时间 >>>> %@",string_date);
    };
    [self.view addSubview:startPicker];
    self.startDatePicker = startPicker;}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
