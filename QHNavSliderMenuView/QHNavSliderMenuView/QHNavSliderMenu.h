//
//  SliderTopNavView.h
//  SliderView
//
//  Created by imqiuhang on 15/3/28.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "UIView+QHUIViewCtg.h"

typedef NS_ENUM(NSInteger, QHNavSliderMenuType) {
    QHNavSliderMenuTypeTitleOnly = 0,
    QHNavSliderMenuTypeTitleAndImage
};

@protocol QHNavSliderMenuDelegate;

@class QHNavSliderMenuStyleModel;

@interface QHNavSliderMenu : UIScrollView<UIScrollViewDelegate>
{
    @protected
    QHNavSliderMenuStyleModel *styleModel;
    
    __weak id<QHNavSliderMenuDelegate>sliderDelegate;
}

/*init*/
- (instancetype)initWithFrame:(CGRect)frame
                andStyleModel:(QHNavSliderMenuStyleModel *)styleModel
                  andDelegate:(id<QHNavSliderMenuDelegate>)delegate
                     showType:(QHNavSliderMenuType)type;

/*!
 *  @author imqiuhang, 15-08-12
 *
 *  @brief  如果外部的视图是可以滑动的  那么滑动了以后 调用这个方法来更改被选中的btn
 *
 *  @param row      第几个 是从0开始的
 *  @param delegate 是否回调 在外部调用的话一般都是no 如果想再次调起delegate则设置为yes 那么就会调起navSliderMenuDidSelectAtRow:(NSInteger)row;
 */
- (void)selectAtRow:(NSInteger)row andDelegate:(BOOL)delegate;

@end

@interface QHNavSliderMenuStyleModel : NSObject


/*menu的标题数组,必传*/
@property (nonatomic,strong) NSArray *menuTitles;

//>>>>>>>>>QHNavSliderMenuType为QHNavSliderMenuTypeTitleAndImage类型需要设置的4个属性
/*未选中显示的图片数组*/
@property (nonatomic,strong) NSArray *menuImagesNormal;
/*选中时显示的图片数组*/
@property (nonatomic,strong) NSArray *menuImagesSelect;
/*未选中时候按钮的颜色*/
@property (nonatomic,strong) UIColor *sliderMenuBtnBgColorForSelect;
/*选中时候按钮的图片*/
@property (nonatomic,strong) UIColor *sliderMenuBtnBgColorForNormal;
//<<<<<<<<<<<<<<<<<<<<<<<<



/*选中时候文字的颜色*/
@property (nonatomic,strong) UIColor *sliderMenuTextColorForSelect;
/*未选中时候文字的颜色*/
@property (nonatomic,strong) UIColor *sliderMenuTextColorForNormal;
/*文字的font 默认是system size10*/
@property (nonatomic,strong) UIFont  *titleLableFont;

/*按钮之间的间距 默认是0*/
@property (nonatomic       ) float   menuHorizontalSpacing;
/*按钮的宽度   默认是屏幕宽度/4 */
@property (nonatomic       ) float   menuWidth;

@end


@protocol QHNavSliderMenuDelegate <NSObject>

@required

///点击了某个按钮
- (void)navSliderMenuDidSelectAtRow:(NSInteger)row;

@optional
///重复点击了某个按钮
- (void)navSliderMenuDidReSelectAtRow:(NSInteger)row;
- (void)navScrollViewDidScroll:(float)offsetX;

@end


