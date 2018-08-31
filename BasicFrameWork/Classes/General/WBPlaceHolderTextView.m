//
//  WBPlaceHolderTextView.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/27.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBPlaceHolderTextView.h"

@interface WBPlaceHolderTextView()

@end

@implementation WBPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        self.delegate = self;
//        self.layer.masksToBounds = true;
//        self.layer.cornerRadius = 5;
//        self.layer.borderColor = THEMECOLOR.CGColor;
//        self.layer.borderWidth = 1;
        self.maxLength = 300;
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)note
{
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
    if (self.markedTextRange == nil && self.text.length > self.maxLength) {
        self.text = [self.text substringToIndex:self.maxLength];
    }

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 每次调用drawRect:方法，都会将以前画的东西清除掉
 */
- (void)drawRect:(CGRect)rect
{
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}


#pragma mark - UITextViewDelegate

// 计算剩余可输入字数 超出最大可输入字数，就禁止输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < self.maxLength) {
            return YES;
        }else{
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxLength - comcatstr.length;
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0, MAX(len, 0)};
        if (rg.length > 0){
            // 因为我的是不需要输入表情，所以没有计算表情的宽度
            //            NSString *s =@"";
            //            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            //            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            //            if (asc) {
            //                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            //            }else{
            //                __block NSInteger idx = 0;
            //                __block NSString  *trimString =@"";//截取出的字串
            //                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
            //                [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
            //                    if (idx >= rg.length) {
            //                        *stop =YES;//取出所需要就break，提高效率
            //                        return ;
            //                    }
            //                    trimString = [trimString stringByAppendingString:substring];
            //                    idx++;
            //                }];
            //                s = trimString;
            //            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
//            [textView setAttributedText: [self textViewAttributedStr:[textView.text stringByReplacingCharactersInRange:range withString:[text substringWithRange:rg]]]];
//            //既然是超出部分截取了，哪一定是最大限制了。
//            self.surplusLbl.text = [NSString stringWithFormat:@"%d/%ld",0,(long)self.maxLength];
        }
        return NO;
    }
}

@end
