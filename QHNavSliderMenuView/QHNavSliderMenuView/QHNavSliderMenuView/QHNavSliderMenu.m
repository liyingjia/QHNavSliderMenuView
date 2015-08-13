//
//  SliderTopNavView.m
//  SliderView
//
//  Created by imqiuhang on 15/3/28.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "QHNavSliderMenu.h"

#define sliderBtnTagStartPoint 10102

@implementation QHNavSliderMenu
{
    NSInteger curSelectRow;
    UIView *bottomTabLine;
    QHNavSliderMenuType menuType;
}
- (instancetype)initWithFrame:(CGRect)frame andStyleModel:(QHNavSliderMenuStyleModel *)aStyleModel andDelegate:(id<QHNavSliderMenuDelegate>)delegate  showType:(QHNavSliderMenuType)type;{
    if (self=[super initWithFrame:frame]) {
       styleModel = aStyleModel;
        self.delegate      = self;
        self.pagingEnabled = NO;
        curSelectRow       = 0;
        menuType = type;
        [self initSliderTopNavView:type];
    }
    return self;
}

- (void)selectAtRow:(NSInteger)row andDelegate:(BOOL)delegate {
    
    if (row>styleModel.menuTitles.count-1||row<0) {
        return;
    }
    if (row==curSelectRow) {
        if (delegate&&[sliderDelegate respondsToSelector:@selector(navSliderMenuDidReSelectAtRow:)]) {
            [sliderDelegate navSliderMenuDidReSelectAtRow:row];
        }
        return;
    }
    if(delegate&&[sliderDelegate respondsToSelector:@selector(navSliderMenuDidSelectAtRow:)]) {
        [sliderDelegate navSliderMenuDidSelectAtRow:row];
    }
    
    UIButton *unSelectBtn =(UIButton *)[self viewWithTag:curSelectRow+sliderBtnTagStartPoint];
    UIButton *selectBtn=(UIButton *)[self viewWithTag:row+sliderBtnTagStartPoint];
    if (menuType==QHNavSliderMenuTypeTitleOnly) {
        [UIView animateWithDuration:ABS(row-curSelectRow)*0.1 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            bottomTabLine.left=selectBtn.left;
        } completion:^(BOOL finished) {
            unSelectBtn.selected=NO;
            selectBtn.selected=YES;
        }];
    }else {
        unSelectBtn.selected=NO;
        selectBtn.selected=YES;
    }

    
    curSelectRow=row;
    [self adjustToScrollView:curSelectRow];
}

//点击后适当滚动以适应
- (void)adjustToScrollView :(NSInteger)row {

    UIButton *selectBtn=(UIButton *)[self viewWithTag:row+sliderBtnTagStartPoint];
    CGPoint btnPosition = [self convertPoint:selectBtn.origin toView:[UIApplication sharedApplication].keyWindow];
    
    if (btnPosition.x+styleModel.menuHorizontalSpacing+styleModel.menuWidth+styleModel.menuWidth/2.f>=self.width) {
        CGPoint offset = self.contentOffset;
        offset.x+=btnPosition.x+styleModel.menuHorizontalSpacing+styleModel.menuWidth+styleModel.menuWidth/2.f-self.width;
        //让最后一个标签露出一半,单必须确保不会超出边界
        offset.x= offset.x>=self.contentSize.width-self.width?self.contentSize.width-self.width:offset.x;
        
        [self setContentOffset:offset animated:YES];
        
    }
    
    if (btnPosition.x-styleModel.menuHorizontalSpacing-styleModel.menuWidth/2.f<0) {
        CGPoint offset = self.contentOffset;
        offset.x-=ABS(btnPosition.x-styleModel.menuHorizontalSpacing-styleModel.menuWidth/2.f);
        offset.x = offset.x<0?0:offset.x;
        [self setContentOffset:offset animated:YES];
    }

}

- (void)sliderBtnSelectEvent:(UIButton *)sender {
    
    [self selectAtRow:sender.tag-sliderBtnTagStartPoint andDelegate:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([sliderDelegate respondsToSelector:@selector(navScrollViewDidScroll:)]) {
        [sliderDelegate navScrollViewDidScroll:scrollView.contentOffset.x];
    }
}

- (void)initSliderTopNavView:(QHNavSliderMenuType)type {

    NSAssert(styleModel.menuTitles, @"顶部滑动栏标题为空?");
    if (type==QHNavSliderMenuTypeTitleAndImage) {
        if(!styleModel.menuImagesNormal) {
           NSAssert(0, @"QHNavSliderMenuTypeTitleAndImage却未传入未选中的显示图片数组?");
        }
        if (!styleModel.menuImagesSelect) {
           NSAssert(0, @"QHNavSliderMenuTypeTitleAndImage却未传入选中时的显示图片数组?");
        }
        
        if(styleModel.menuTitles.count<styleModel.menuImagesNormal.count||styleModel.menuTitles.count<styleModel.menuImagesSelect.count) {
            NSAssert(0, @"标题和图片的数量不一致!");
        }
    }
    
    if (!styleModel.sliderMenuTextColorForNormal) {
        styleModel.sliderMenuTextColorForNormal = QHRGB(140, 140, 140);;
    }
    if (!styleModel.sliderMenuTextColorForSelect) {
        styleModel.sliderMenuTextColorForSelect = QHRGB(226, 12, 12);
    }
    if (!styleModel.titleLableFont ) {
        styleModel.titleLableFont  = defaultFont(12);
    }
    if (styleModel.menuWidth <=0) {
        styleModel.menuWidth = QHScreenWidth /4.f;
    }
    if (styleModel.menuHorizontalSpacing<=0 ) {
        styleModel.menuHorizontalSpacing = 0.f;
    }
    
    self.showsVerticalScrollIndicator   = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = YES;
    self.contentSize = CGSizeMake((styleModel.menuWidth+styleModel.menuHorizontalSpacing)*styleModel.menuTitles.count+styleModel.menuHorizontalSpacing, 44);
    
    if (menuType==QHNavSliderMenuTypeTitleOnly) {

        bottomTabLine=[[UIView alloc] initWithFrame:CGRectMake(styleModel.menuHorizontalSpacing, 0, styleModel.menuWidth, 2)];
        bottomTabLine.bottom = self.height-2.f;
        bottomTabLine.backgroundColor = styleModel.sliderMenuTextColorForSelect;
        [self addSubview:bottomTabLine];
    }
    
    for(int i=0;i<styleModel.menuTitles.count;i++) {
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake((styleModel.menuHorizontalSpacing+styleModel.menuWidth)*i, 0, styleModel.menuWidth, self.height)];
        btn.centerY = self.height/2.f;
        [btn addTarget:self action:@selector(sliderBtnSelectEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted=NO;
        btn.selected=i==0?YES:NO;
        btn.tag = sliderBtnTagStartPoint+i;//加上初始值防止tag冲突 计算的时候要减去初始值对应row
        [btn setTitle:styleModel.menuTitles[i] forState:UIControlStateNormal];
        [btn setTitle:styleModel.menuTitles[i] forState:UIControlStateSelected];
        
        [btn setTitleColor:styleModel.sliderMenuTextColorForSelect forState:UIControlStateSelected];
        [btn setTitleColor:styleModel.sliderMenuTextColorForNormal forState:UIControlStateNormal];
        btn.titleLabel.font=styleModel.titleLableFont;
        [self addSubview:btn];
    
        if (type==QHNavSliderMenuTypeTitleAndImage) {
            [btn setImage:styleModel.menuImagesNormal[i] forState:UIControlStateNormal];
            [btn setImage:styleModel.menuImagesSelect[i] forState:UIControlStateSelected];
            CGRect imgBounds = btn.imageView.bounds;
            UIEdgeInsets imgInsets = UIEdgeInsetsZero;
            UIEdgeInsets titleInsets = UIEdgeInsetsZero;
            imgInsets.bottom = btn.frame.size.height / 2 -10;
            imgInsets.right = (btn.frame.size.width - imgBounds.size.width)/2;
            imgInsets.left = (btn.frame.size.width - imgBounds.size.width)/2;
            titleInsets.top = btn.frame.size.height / 2 ;
            titleInsets.left =-imgBounds.size.width;
            
            [btn setImageEdgeInsets:imgInsets];
            [btn setTitleEdgeInsets:titleInsets];
        }


    }
    
}


@end

@implementation QHNavSliderMenuStyleModel



@end
