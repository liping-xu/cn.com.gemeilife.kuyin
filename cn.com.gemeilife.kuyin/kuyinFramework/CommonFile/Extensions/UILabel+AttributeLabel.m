//
//  UILabel+AttributeLabel.m
//  Test
//
//  Created by 许文波 on 16/2/24.
//  Copyright © 2016年 dxzq.net. All rights reserved.
//

#import "UILabel+AttributeLabel.h"
#import <CoreText/CoreText.h>

@implementation UILabel (AttributeLabel)

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont*)font
{
    self.textColor = textColor;
    self.textAlignment = textAlignment;
    self.font = font;
}

/**
 *  图文混排(单张)
 *
 *  @param imageName  图片名称
 *  @param frame      图片frame
 *  @param index      图片插入下标
 *  @param imageSpace 图片和文字间距
 */

- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace
{
    [self setImageWithImageName:imageName imageSize:size index:index withImageSpace:imageSpace withImageCount:1 withTextSpacing:0];
}

/**
 *  图文混排(多张图片)
 *
 *  @param imageName  图片名称
 *  @param frame      图片frame
 *  @param index      图片插入下标
 *  @param imageSpace 图片和文字间距
 *  @param imageCount 图片数量
 */


- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace withImageCount:(NSInteger)imageCount 
{
    [self setImageWithImageName:imageName imageSize:size index:index withImageSpace:imageSpace withImageCount:imageCount withTextSpacing:0];
}

/**
 *  图文混排
 *
 *  @param imageName   图片名称
 *  @param frame       图片frame
 *  @param index       图片插入下标
 *  @param imageSpace  图片和文字间距
 *  @param textSpacing 字间距
 */
- (void)setImageWithImageName:(NSString *)imageName imageSize:(CGSize)size index:(NSInteger)index withImageSpace:(NSInteger)imageSpace withImageCount:(NSInteger)imageCount withTextSpacing:(NSInteger)textSpacing
{
    
    // 图片和文字的距离
    NSMutableString *spaceString = [[NSMutableString alloc] init];
    for (int i = 0; i < imageSpace; i++) {
        [spaceString appendString:@" "];
    }
    NSMutableString *muString = [[NSMutableString alloc] initWithString:self.text ? self.text : @""];
    [muString insertString:spaceString atIndex:index];
    if (index != 0) {
        index = muString.length;
    }
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:muString  attributes:nil];
    for (int i = 0; i < imageCount; i++) {
        // 添加表情
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:imageName];
        // 设置图片大小
        attch.bounds = CGRectMake(i == 0 ? 0 : index == 0 ? - 5 * i : 5 * i, 0, size.width, size.height);
        // 创建带有图片的富文本
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        if (index == 0) {
            [att insertAttributedString:string atIndex:index];
        } else {
            [att appendAttributedString:string];
        }
    }
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&textSpacing);
    [att addAttribute:(id)kCTKernAttributeName value:(__bridge id)(num) range:NSMakeRange(0,self.text.length)];
    CFRelease(num);
    
    self.attributedText = att;
    [self setNeedsDisplay];
}



/**
 *  字间距
 *
 *  @param spacing 间距
 */
- (void)setTextSpace:(NSInteger)spacing
{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:self.text  attributes:nil];
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&spacing);
    [att addAttribute:(id)kCTKernAttributeName value:(__bridge id)(num) range:NSMakeRange(0,self.text.length)];
    CFRelease(num);
    self.attributedText = att;
    [self setNeedsDisplay];
}

/**
 *  行间距
 *
 *  @param spacing 行间距
 */
- (void)setLineSpace:(NSInteger)spacing
{
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self setNeedsDisplay];
}

/**
 *  富文本label 颜色和字体大小都用本身属性
 *
 *  @param texts   texts
 *  @param isWarp  是否换行（每一个text元素换行）
 *  @param spacing 行间距
 */
- (void)setTexts:(NSArray *)texts warp:(BOOL)isWarp spacing:(CGFloat)spacing
{
    NSMutableArray *colorArray = [NSMutableArray new];
    NSMutableArray *fontArray = [NSMutableArray new];
    NSMutableArray *warpArray = [NSMutableArray new];
    for (int i = 0; i < texts.count; i++) {
        [colorArray addObject:self.textColor];
        [fontArray addObject:self.font];
        if (isWarp) {
            [warpArray addObject:@"1"];
        } else {
            [warpArray addObject:@"0"];
        }
    }
    [self setTexts:texts colors:colorArray fonts:fontArray warps:warpArray spacing:spacing];
}

/**
 *  富文本label 颜色都用本身属性
 *
 *  @param texts   texts
 *  @param fonts   字号数组
 *  @param isWarp  是否换行（每一个text元素换行）
 *  @param spacing 行间距
 */
- (void)setTexts:(NSArray *)texts fonts:(NSArray*)fonts warp:(BOOL)isWarp spacing:(CGFloat)spacing
{
    NSMutableArray *colorArray = [NSMutableArray new];
    NSMutableArray *warpArray = [NSMutableArray new];
    for (int i = 0; i < texts.count; i++) {
        [colorArray addObject:self.textColor];
        if (isWarp) {
            [warpArray addObject:@"1"];
        } else {
            [warpArray addObject:@"0"];
        }
    }
    [self setTexts:texts colors:colorArray fonts:fonts warps:warpArray spacing:spacing];
}

/**
 *  富文本label 字体大小用本身属性
 *
 *  @param texts   texts
 *  @param colors   颜色数组
 *  @param isWarp  是否换行（每一个text元素换行）
 *  @param spacing 行间距
 */
- (void)setTexts:(NSArray *)texts colors:(NSArray*)colors warp:(BOOL)isWarp spacing:(CGFloat)spacing
{
    NSMutableArray *fontArray = [NSMutableArray new];
    NSMutableArray *warpArray = [NSMutableArray new];
    for (int i = 0; i < texts.count; i++) {
        [fontArray addObject:self.font];
        if (isWarp) {
            [warpArray addObject:@"1"];
        } else {
            [warpArray addObject:@"0"];
        }
    }
    [self setTexts:texts colors:colors fonts:fontArray warps:warpArray spacing:spacing];
}

/**
 *  富文本label 颜色用本身属性
 *
 *  @param texts     text数组
 *  @param fonts     字号数组
 *  @param warps     换行数组 0 不换行， 1 换行
 *  @param spacing   行间距
 */
- (void)setTexts:(NSArray *)texts fonts:(NSArray *)fonts warps:(NSArray *)warps spacing:(CGFloat)spacing
{
    NSMutableArray *colorArray = [NSMutableArray new];
    for (int i = 0; i < texts.count; i++) {
        [colorArray addObject:self.textColor];
        
    }
    [self setTexts:texts colors:colorArray fonts:fonts warps:warps spacing:spacing];
}

/**
 *  富文本label
 *
 *  @param texts     text数组
 *  @param colors    颜色数组
 *  @param fonts     字号数组
 *  @param isWarp  是否换行（每一个text元素换行）
 *  @param spacing   行间距
 *
 *  @return label
 */
- (void)setTexts:(NSArray *)texts colors:(NSArray *)colors fonts:(NSArray *)fonts warp:(BOOL)isWarp spacing:(CGFloat)spacing
{
    NSMutableArray *warpArray = [NSMutableArray new];
    for (int i = 0; i < texts.count; i++) {
        if (isWarp) {
            [warpArray addObject:@"1"];
        } else {
            [warpArray addObject:@"0"];
        }
    }
    
    [self setTexts:texts colors:colors fonts:fonts warps:warpArray spacing:spacing];
}


/**
 *  富文本label
 *
 *  @param texts     text数组
 *  @param colors    颜色数组
 *  @param fonts     字号数组
 *  @param warps     换行数组 0 不换行， 1 换行
 *  @param spacing   行间距
 *
 *  @return label
 */
- (void)setTexts:(NSArray *)texts colors:(NSArray *)colors fonts:(NSArray *)fonts warps:(NSArray *)warps spacing:(CGFloat)spacing
{
    NSString *warpSign = nil;
    self.numberOfLines = 0;
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempTextArray = [[NSMutableArray alloc] init];
    NSMutableString *muString = [[NSMutableString alloc] init];
    for (int i = 0; i < texts.count; i++) {
        if ([warps[i] intValue] == 1) {
            warpSign = @"\n";
        } else {
            warpSign = @"";
        }
        [tempTextArray addObject:[NSString stringWithFormat:@"%@%@",texts[i], warpSign]];
        [muString appendString:tempTextArray[i]];
    }
    
    for (int i = 0; i < tempTextArray.count; i++) {
        if (i == 0) {
            [newArray addObject:[NSString stringWithFormat:@"%@", tempTextArray[i]]];
        } else {
            [newArray addObject:[NSString stringWithFormat:@"%@%@", newArray[i - 1], tempTextArray[i]]];
        }
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:muString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [paragraphStyle setParagraphSpacing:0];
    paragraphStyle.alignment = self.textAlignment;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, muString.length)];
    for (int i = 0; i < texts.count; i++) {
        [att addAttribute:NSForegroundColorAttributeName value:colors[i] range:NSMakeRange([newArray[i] length] - [tempTextArray[i] length], [tempTextArray[i] length])];
        [att addAttribute:NSFontAttributeName value:fonts[i] range:NSMakeRange([newArray[i] length] - [tempTextArray[i] length], [tempTextArray[i] length])];
        [att addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange([newArray[i] length] - [tempTextArray[i] length], [tempTextArray[i] length])];
    }
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    long number = 0;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [att addAttribute:(id)kCTKernAttributeName value:(__bridge id)(num) range:NSMakeRange(0, muString.length)];
    CFRelease(num);
    self.attributedText = att;
}

@end
