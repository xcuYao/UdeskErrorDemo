//
//  UdeskLocationMessage.m
//  UdeskSDK
//
//  Created by xuchen on 2017/8/16.
//  Copyright © 2017年 Udesk. All rights reserved.
//

#import "UdeskLocationMessage.h"
#import "UdeskLocationCell.h"

/** 地理位置宽度 */
static CGFloat const kUDLocationMessageWidth = 220;
/** 地理位置高度 */
static CGFloat const kUDLocationMessageHeight = 145;
/** 地理位置快照宽度 */
static CGFloat const kUDLocationSnapshotMessageWidth = 220;
/** 地理位置快照高度 */
static CGFloat const kUDLocationSnapshotMessageHeight = 90;
/** 地理位置名称高度 */
static CGFloat const kUDLocationNameMessageHeight = 20;
/** 地理位置名称高度 */
static CGFloat const kUDLocationThoroughfareMessageHeight = 15;
/** 地理位置名称水平距离 */
static CGFloat const kUDLocationNameToHorizontalEdgeSpacing = 8;
/** 地理位置快照水平距离 */
static CGFloat const kUDLocationSnapshotToHorizontalEdgeSpacing = 0;
/** 地理位置快照垂直距离 */
static CGFloat const kUDLocationSnapshotToVerticalEdgeSpacing = 7;

@interface UdeskLocationMessage()

/** 地理位置frame */
@property (nonatomic, assign, readwrite) CGRect locationFrame;
/** 地理位置名称frame */
@property (nonatomic, assign, readwrite) CGRect locationNameFrame;
/** 地理位置街道frame */
@property (nonatomic, assign, readwrite) CGRect locationThoroughfareFrame;
/** 地理位置快照frame */
@property (nonatomic, assign, readwrite) CGRect locationSnapshotFrame;

@end

@implementation UdeskLocationMessage

- (instancetype)initWithMessage:(UdeskMessage *)message displayTimestamp:(BOOL)displayTimestamp
{
    self = [super initWithMessage:message displayTimestamp:displayTimestamp];
    if (self) {
        
        [self layoutLocationMessage];
    }
    return self;
}

- (void)layoutLocationMessage {
    
    switch (self.message.messageFrom) {
        case UDMessageTypeSending:{
            
            //图片气泡位置
            CGFloat locationX = UD_SCREEN_WIDTH-kUDBubbleToHorizontalEdgeSpacing-kUDLocationMessageWidth;
            self.locationFrame = CGRectMake(locationX, CGRectGetMaxY(self.avatarFrame)+kUDAvatarToBubbleSpacing, kUDLocationMessageWidth, kUDLocationMessageHeight);
            //地图图片位置
            self.locationSnapshotFrame = CGRectMake(kUDLocationSnapshotToHorizontalEdgeSpacing, 0, kUDLocationSnapshotMessageWidth, kUDLocationSnapshotMessageHeight);
            //地图名称位置
            self.locationNameFrame = CGRectMake(kUDLocationNameToHorizontalEdgeSpacing, CGRectGetMaxY(self.locationSnapshotFrame)+ kUDLocationSnapshotToVerticalEdgeSpacing, kUDLocationMessageWidth-kUDLocationNameToHorizontalEdgeSpacing*2, kUDLocationNameMessageHeight);
            //地理位置街道位置
            self.locationThoroughfareFrame = CGRectMake(kUDLocationNameToHorizontalEdgeSpacing, CGRectGetMaxY(self.locationNameFrame)+ kUDLocationSnapshotToVerticalEdgeSpacing, kUDLocationMessageWidth-kUDLocationNameToHorizontalEdgeSpacing*2, kUDLocationThoroughfareMessageHeight);
            //发送中frame
            self.loadingFrame = CGRectMake(self.bubbleFrame.origin.x-kUDBubbleToSendStatusSpacing-kUDSendStatusDiameter, self.bubbleFrame.origin.y+kUDCellBubbleToIndicatorSpacing, kUDSendStatusDiameter, kUDSendStatusDiameter);
            //发送失败frame
            self.failureFrame = self.loadingFrame;
            
            break;
        }
            
        default:
            break;
    }
    
    //cell高度
    self.cellHeight = self.locationFrame.size.height+self.locationFrame.origin.y+kUDCellBottomMargin;
}

- (UITableViewCell *)getCellWithReuseIdentifier:(NSString *)cellReuseIdentifer {
    
    return [[UdeskLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifer];
}

@end
