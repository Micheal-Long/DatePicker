//
//  WPCircleScrollView.h
//
//  根据需求改写自RBCustomDateTimePicker
//  https://github.com/CoderXL/RBCustomDateTimePicker
//
//  Created by wupei on 16/2/4.
//  Copyright © 2016年 WuPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  WPCircleScrollViewDelegate;
@protocol  WPCircleScrollViewDataScource;

@interface WPCircleScrollView : UIView <UIScrollViewDelegate>
{
    /**滚动视图 */
    UIScrollView *_scrollView;
    /**scroll总页数 */
    NSInteger _totalPages;
    /**当前页 */
    NSInteger _curPage;
    /**当前页的view */
    NSMutableArray *_curViews;
}
/**只读scroll */
@property (nonatomic,readonly) UIScrollView *scrollView;
/**当前页 */
@property (nonatomic,assign) NSInteger currentPage;
/**代理 */
@property (nonatomic,assign,setter = setDataource:) id<WPCircleScrollViewDataScource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<WPCircleScrollViewDelegate> delegate;
/**设置初始化页数 */
- (void)setCurrentSelectPage:(NSInteger)selectPage;
/**刷新页数 */
- (void)reloadData;
/**设置选中页 */
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end
/**Delegate */
@protocol WPCircleScrollViewDelegate <NSObject>
@optional
/**滑动年月日时分秒 */
- (void)didClickPage:(WPCircleScrollView *)csView atIndex:(NSInteger)index;
/**改变日期  */
- (void)scrollviewDidChangeNumber;

@end
/**DataSource */
@protocol WPCircleScrollViewDataScource <NSObject>
@required
/**每个scroll的个数 */
- (NSInteger)numberOfPages:(WPCircleScrollView*)scrollView;
/**选中的页 */
- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(WPCircleScrollView*)scrollView;

@end
