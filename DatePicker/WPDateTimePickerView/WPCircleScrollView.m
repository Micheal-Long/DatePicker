//
//  WPCircleScrollView.m
//
//  根据需求改写自RBCustomDateTimePicker
//  https://github.com/CoderXL/RBCustomDateTimePicker
//
//  Created by wupei on 16/2/4.
//  Copyright © 2016年 WuPei. All rights reserved.
//

#import "WPCircleScrollView.h"

/**颜色和透明度设置 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
@implementation WPCircleScrollView
@synthesize scrollView = _scrollView;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;
/**
 *  初始化init方法
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, (self.bounds.size.height/3)*7);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, (self.bounds.size.height/3));
        [self addSubview:_scrollView];
    }
    return self;
}
/**
 *  设置初始化页数
 */
- (void)setCurrentSelectPage:(NSInteger)selectPage {
    
    _curPage = selectPage;
}
/**
 *  设置DataSource
 */
- (void)setDataource:(id<WPCircleScrollViewDataScource>)datasource {
    
    _datasource = datasource;
    [self reloadData];
}
/**
 *  刷新总数
 */
- (void)reloadData {
    
    _totalPages = [_datasource numberOfPages:self];
    if (_totalPages == 0) {
        return;
    }
    [self loadData];
}
/**
 *  加载总页数
 */
- (void)loadData {
    //  从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 7; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.frame = CGRectOffset(v.frame, 0, v.frame.size.height * i );
        [_scrollView addSubview:v];
    }
    [_scrollView setContentOffset:CGPointMake( 0, (self.bounds.size.height/3) )];
}
/**
 *
 */
- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    
    NSInteger pre1 = [self validPageValue:_curPage-1];
    NSInteger pre2 = [self validPageValue:_curPage];
    NSInteger pre3 = [self validPageValue:_curPage+1];
    NSInteger pre4 = [self validPageValue:_curPage+2];
    NSInteger pre5 = [self validPageValue:_curPage+3];
    NSInteger pre = [self validPageValue:_curPage+4];
    NSInteger last = [self validPageValue:_curPage+5];
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    [_curViews removeAllObjects];
    [_curViews addObject:[_datasource pageAtIndex:pre1 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre2 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre3 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre4 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre5 andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:pre andScrollView:self]];
    [_curViews addObject:[_datasource pageAtIndex:last andScrollView:self]];
}
/**
 *
 */
- (NSInteger)validPageValue:(NSInteger)value {
    if(value == -2 ) value = _totalPages - 2;
    if(value == -1 ) value = _totalPages - 1;
    if(value == _totalPages+1) value = 1;
    if (value == _totalPages+2) value = 2;
    if(value == _totalPages+3) value = 3;
    if (value == _totalPages+4) value = 4;
    if(value == _totalPages) value = 0;
    return value;
}
/**
 *  设置contentView
 */
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index {
    
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 7; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            v.frame = CGRectOffset(v.frame, 0, v.frame.size.height * i);
            [_scrollView addSubview:v];
        }
    }
}
/**
 *  设置scroll覆盖Label
 *
 *  @param scrollview <#scrollview description#>
 *  @param pageNumber <#pageNumber description#>
 */
- (void)setAfterScrollShowView:(UIScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber {
    //  第一个label >>> 顶部
    UILabel *topLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber];
//    [topLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [topLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [topLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    //  中间label
    UILabel *currentLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+1];
//    [currentLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [currentLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [currentLabel setTextColor:[UIColor blackColor]];
    //  底部label
    UILabel *bottomLabel = (UILabel*)[[scrollview subviews] objectAtIndex:pageNumber+2];
//    [bottomLabel setFont:[UIFont systemFontOfSize:[[userDefault objectForKey:@"font_16"] floatValue]]];
    [bottomLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bottomLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int y = aScrollView.contentOffset.y;
    NSInteger page = aScrollView.contentOffset.y/((self.bounds.size.height/5));
    
    if (y>2*(self.bounds.size.height/5)) {
        _curPage = [self validPageValue:_curPage+1];
        [self reloadData];
    }
    if (y<=0) {
        _curPage = [self validPageValue:_curPage-1];
        [self reloadData];
    }
    if (page>1 || page <=0) {
        [self setAfterScrollShowView:aScrollView andCurrentPage:1];
    }
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        
        [_delegate scrollviewDidChangeNumber];
    }
}
/**
 *
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
}
/**
 *
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [_scrollView setContentOffset:CGPointMake(0, (self.bounds.size.height/3)) animated:YES];
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        [_delegate scrollviewDidChangeNumber];
    }
}
/**
 *
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
}
/**
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_scrollView setContentOffset:CGPointMake(0, (self.bounds.size.height/3)) animated:YES];
    [self setAfterScrollShowView:scrollView andCurrentPage:1];
    if ([_delegate respondsToSelector:@selector(scrollviewDidChangeNumber)]) {
        [_delegate scrollviewDidChangeNumber];
    }
}


@end
