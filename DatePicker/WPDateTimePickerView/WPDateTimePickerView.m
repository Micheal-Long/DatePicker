//
//  WPDateTimePickerView.m
//
//  根据需求改写自RBCustomDateTimePicker
//  https://github.com/CoderXL/RBCustomDateTimePicker
//
//  Created by wupei on 16/2/4.
//  Copyright © 2016年 WuPei. All rights reserved.
//

#import "WPDateTimePickerView.h"
#import "WPCircleScrollView.h"
/**颜色和透明度设置 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define EachScrollWidth self.frame.size.width/5.0

#define Width self.frame.size.width

#define Height self.frame.size.height

@interface WPDateTimePickerView()<WPCircleScrollViewDataScource,WPCircleScrollViewDelegate>
/**定时播放显示视图 */
@property (strong, nonatomic) UIView *timeBroadcastView;
/**年份滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *yearScrollView;
/**月份滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *monthScrollView;
/**日滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *dayScrollView;
/**时滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *hourScrollView;
/**分滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *minuteScrollView;
/**秒滚动视图 */
@property (strong, nonatomic) WPCircleScrollView *secondScrollView;
/**选中的年份 */
@property (assign, nonatomic) NSInteger selectYear;
/**选中的月份 */
@property (assign, nonatomic) NSInteger selectMonth;
//@property (strong, nonatomic) NSDate *date;
@end

@implementation WPDateTimePickerView
/**
 *  初始化init方法
 */
- (id)initWithFrame:(CGRect)frame withDate:(NSDate *)date{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        _date = date;
        [self setTimeBroadcastView];

    }
    return self;
}
/**
 *  设置时间
 */
- (void)setDate:(NSDate *)date {
    
   }
#pragma mark -custompicker
//设置自定义datepicker界面
- (void)setTimeBroadcastView{
    //  时间时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *dateString = [dateFormatter stringFromDate:_date];
    NSInteger monthInt = [dateString substringWithRange:NSMakeRange(4, 2)].integerValue;
    //  设置默认年月
    NSInteger yearInt = [dateString substringWithRange:NSMakeRange(0, 4)].integerValue;
    _selectYear = yearInt;
    _selectMonth = monthInt;
    //  覆盖物
    _timeBroadcastView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_timeBroadcastView];
    //  顶部分割线
    for (int i = 0; i < 5; i ++) {
        
        UIView *beforeSepLine = [[UIView alloc] initWithFrame:CGRectMake(EachScrollWidth*i, Height/3-1, EachScrollWidth, 1.0)];
        [beforeSepLine setBackgroundColor:RGBA(47.0, 131.0, 191.0, 1.0)];
        [_timeBroadcastView addSubview:beforeSepLine];
    }
    //  中间view
    UIView *middleSepView = [[UIView alloc] initWithFrame:CGRectMake(0, Height/3+1, Width, Height/3.0)];
    [middleSepView setBackgroundColor:[UIColor clearColor]];
    [_timeBroadcastView addSubview:middleSepView];
    //  底部分割线
    for (int j = 0; j < 5; j ++) {
        
        UIView *bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(EachScrollWidth*j, Height/3*2, EachScrollWidth, 1.0)];
        [bottomSepLine setBackgroundColor:RGBA(47.0, 131.0, 191.0, 1.0)];
        [_timeBroadcastView addSubview:bottomSepLine];
    }
    //  设置各个滚动选择scroll
    [self setYearScrollView];
    [self setMonthScrollView];
    [self setDayScrollView];
    [self setHourScrollView];
    [self setMinuteScrollView];
}
/**
 *  设置年的滚动视图
 */
- (void)setYearScrollView {
    
    _yearScrollView = [[WPCircleScrollView alloc] initWithFrame:CGRectMake(0, 0, EachScrollWidth, Height)];
    NSInteger yearint = [self setNowTimeShow:0];
    [_yearScrollView setCurrentSelectPage:(yearint-2001)];
    _yearScrollView.delegate = self;
    _yearScrollView.datasource = self;
    [self setAfterScrollShowView:_yearScrollView andCurrentPage:1];
    [_timeBroadcastView addSubview:_yearScrollView];
}
/**
 *  设置月的滚动视图
 */
- (void)setMonthScrollView {
    
    _monthScrollView = [[WPCircleScrollView alloc] initWithFrame:CGRectMake(EachScrollWidth, 0, EachScrollWidth, Height)];
    NSInteger monthint = [self setNowTimeShow:1];
    [_monthScrollView setCurrentSelectPage:(monthint-2)];
    _monthScrollView.delegate = self;
    _monthScrollView.datasource = self;
    [self setAfterScrollShowView:_monthScrollView andCurrentPage:1];
    [_timeBroadcastView addSubview:_monthScrollView];
}
/**
 *  设置日的滚动视图
 */
- (void)setDayScrollView {
    
    _dayScrollView = [[WPCircleScrollView alloc] initWithFrame:CGRectMake(EachScrollWidth*2, 0, EachScrollWidth, Height)];
    NSInteger dayint = [self setNowTimeShow:2];
    [_dayScrollView setCurrentSelectPage:(dayint-2)];
    _dayScrollView.delegate = self;
    _dayScrollView.datasource = self;
    [self setAfterScrollShowView:_dayScrollView andCurrentPage:1];
    [_timeBroadcastView addSubview:_dayScrollView];
}
/**
 *  设置时的滚动视图
 */
- (void)setHourScrollView {
    
    _hourScrollView = [[WPCircleScrollView alloc] initWithFrame:CGRectMake(EachScrollWidth*3, 0, EachScrollWidth, Height)];
    NSInteger hourint = [self setNowTimeShow:3];
    [_hourScrollView setCurrentSelectPage:(hourint-1)];
    _hourScrollView.delegate = self;
    _hourScrollView.datasource = self;
    [self setAfterScrollShowView:_hourScrollView andCurrentPage:1];
    [_timeBroadcastView addSubview:_hourScrollView];
}
/**
 *  设置分的滚动视图
 */
- (void)setMinuteScrollView {
    
    _minuteScrollView = [[WPCircleScrollView alloc] initWithFrame:CGRectMake(EachScrollWidth*4, 0, EachScrollWidth, Height)];
    NSInteger minuteint = [self setNowTimeShow:4];
    [_minuteScrollView setCurrentSelectPage:(minuteint-1)];
    _minuteScrollView.delegate = self;
    _minuteScrollView.datasource = self;
    [self setAfterScrollShowView:_minuteScrollView andCurrentPage:1];
    [_timeBroadcastView addSubview:_minuteScrollView];
}
/**
 *  设置scroll显示label
 */
- (void)setAfterScrollShowView:(WPCircleScrollView *)scrollview  andCurrentPage:(NSInteger)pageNumber {
    //  顶部label
    UILabel *topLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
//    [topLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [topLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [topLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    //  中间label
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
//    [currentLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [currentLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [currentLabel setTextColor:[UIColor blackColor]];
    //  底部label
    UILabel *bottomLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
//    [bottomLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [bottomLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bottomLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
/**
 *  设置数据
 */
- (NSInteger)numberOfPages:(WPCircleScrollView *)scrollView {
    
    if (scrollView == _yearScrollView) {
        return 99;
    }else if (scrollView == _monthScrollView) {
        return 12;
    }else if (scrollView == _dayScrollView) {
        
        NSInteger rowNum = 0;
        NSInteger year = _selectYear;
        NSInteger month = _selectMonth;
        if (month == 1 || month == 3 || month == 5 || month == 7|| month == 8 || month == 10 || month == 12) {
            rowNum = 31;
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            rowNum = 30;
        } else if (month == 2) {
            BOOL isLeapYear = ((year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0));//闰年
            NSInteger wholdDaysOfMonth = (isLeapYear ? 29 : 28);
            rowNum = wholdDaysOfMonth;
        }
        return rowNum;
    }else if (scrollView == _hourScrollView) {
        return 24;
    }
    return 60;
}
/**
 *  label赋值
 */
- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(WPCircleScrollView *)scrollView {
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/3)];
    l.tag = index+1;
    if (scrollView == _yearScrollView) {
        l.text = [NSString stringWithFormat:@"%ld年",2000+index];
    }else if (scrollView == _monthScrollView) {
        if (index < 9) {
            l.text = [NSString stringWithFormat:@"0%ld月",1+index];
        }else {
            l.text = [NSString stringWithFormat:@"%ld月",1+index];
        }
    }else if (scrollView == _dayScrollView) {
        if (index < 9) {
            l.text = [NSString stringWithFormat:@"0%ld日",1+index];
        }else {
            l.text = [NSString stringWithFormat:@"%ld日",1+index];
        }
    }else if (scrollView == _hourScrollView) {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld",(long)index];
        }else {
            l.text = [NSString stringWithFormat:@"%ld",(long)index];
        }
    }else if (scrollView == _minuteScrollView) {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld",(long)index];
        }else {
            l.text = [NSString stringWithFormat:@"%ld",(long)index];
        }
    }
//    l.font = [UIFont systemFontOfSize:[[userDefault objectForKey:@"font_20"] floatValue]];
    l.font = [UIFont systemFontOfSize:20];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    l.textColor = RGBA(113.0, 113.0, 113.0, 1.0);
    return l;
}
/**
 *  设置现在时间
 */
- (NSInteger)setNowTimeShow:(NSInteger)timeType {
    
    NSDate *now = _date;//[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *dateString = [dateFormatter stringFromDate:now];
    switch (timeType) {
        case 0: {
            NSRange range = NSMakeRange(0, 4);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 1: {
            NSRange range = NSMakeRange(4, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 2: {
            NSRange range = NSMakeRange(6, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 3: {
            NSRange range = NSMakeRange(8, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 4: {
            NSRange range = NSMakeRange(10, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        default:
            break;
    }
    return 0;
}
/**
 *  滚动时上下标签显示(当前时间和是否为有效时间)
 */
- (void)scrollviewDidChangeNumber {
    
    UILabel *yearLabel = [[(UILabel*)[[_yearScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *monthLabel = [[(UILabel*)[[_monthScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *dayLabel = [[(UILabel*)[[_dayScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *hourLabel = [[(UILabel*)[[_hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[_minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    
    NSInteger yearInt = yearLabel.tag + 1998;
    if (yearInt == 1999) {
        yearInt = 2098;
    }
    _selectYear = yearInt;
    NSInteger monthInt = monthLabel.tag-1;
    if (monthInt == 0) {
        monthInt = 12;
    }
    _selectMonth = monthInt;
    NSInteger dayInt = dayLabel.tag-1;
    if (dayInt == 0) {
        //  判断tag值==0的情况
        if (monthInt == 1 || monthInt == 3 || monthInt == 5 || monthInt == 8 || monthInt == 10 || monthInt == 12) {
            dayInt = 31;
        }else if (monthInt == 4 || monthInt == 6 || monthInt == 9 || monthInt == 11) {
            dayInt = 30;
        } else if (monthInt == 2) {
            BOOL isLeapYear = ((yearInt % 4 == 0 && yearInt % 100 != 0) || (yearInt % 400 == 0));//闰年
            NSInteger wholdDaysOfMonth = (isLeapYear ? 29 : 28);
            dayInt = wholdDaysOfMonth;
        }
    }
    NSInteger hourInt = hourLabel.text.integerValue-1;
    if (hourInt == -1) {
        hourInt = 23;
    }
    NSInteger minuteInt = minuteLabel.text.integerValue-1;
    if (minuteLabel.text.integerValue == 0) {
        minuteInt = 59;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *selectTimeString = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",yearInt,monthInt,dayInt,hourInt,minuteInt];
    NSDate *selectDate = [dateFormatter dateFromString:selectTimeString];
    if (self.clickDateTimePicker) {
        self.clickDateTimePicker(selectDate);
    }
}
/**
 *  通过日期求星期
 */
- (NSString*)fromDateToWeek:(NSString*)selectDate {
    
    NSInteger yearInt = [selectDate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger monthInt = [selectDate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [selectDate substringWithRange:NSMakeRange(6, 2)].integerValue;
    int c = 20;//世纪
    NSInteger y = yearInt -1;//年
    NSInteger d = dayInt;
    NSInteger m = monthInt;
    NSInteger w =(y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1)%7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"周日";
            break;
        case 1:
            weekDay = @"周一";
            break;
        case 2:
            weekDay = @"周二";
            break;
        case 3:
            weekDay = @"周三";
            break;
        case 4:
            weekDay = @"周四";
            break;
        case 5:
            weekDay = @"周五";
            break;
        case 6:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

@end
