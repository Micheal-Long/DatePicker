//
//  WPDateTimePickerView.h
//
//  根据需求改写自RBCustomDateTimePicker
//  https://github.com/CoderXL/RBCustomDateTimePicker
//
//  Created by wupei on 16/2/4.
//  Copyright © 2016年 WuPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPDateTimePickerView : UIView
- (id)initWithFrame:(CGRect)frame withDate:(NSDate *)date;
/**设置初始化时间 */
@property (strong, nonatomic) NSDate *date;
/**点击事件 */
@property (nonatomic, copy) void (^clickDateTimePicker)(NSDate *timeDate);

@end
