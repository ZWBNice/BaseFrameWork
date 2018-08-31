//
//  CommentView.h
//  breathPatientApp
//
//  Created by ifly on 2018/8/6.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentView;

@protocol CommentViewDelegate <NSObject>

@optional

-(void)commentView:(CommentView*)commentView sendMessage:(NSString*)message complete:(void(^)(BOOL success))completeBlock;

@end

@interface CommentView : UIView

@property (strong, nonatomic)  UITextView *commentTV;

@property (strong, nonatomic)  UILabel *tipLabel; // 提示

@property (strong, nonatomic)  UIButton *senderBtn;

@property (nonatomic,weak) id <CommentViewDelegate> delegate;

@end

