//
//  UIImage+Symbolset.m
//
//  Copyright (c) 2013 Bradley David Bergeron
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "NSAttributedString+Symbolset.h"
#import "UIImage+Symbolset.h"


#pragma mark -
@implementation UIImage (Symbolset)

+ (instancetype)symbolsetIconNamed:(NSString *)iconName withFont:(SSFontName)font size:(CGSize)size
{
    static NSCache *_ssIconCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ssIconCache = [NSCache new];
    });

    if (CGSizeEqualToSize(size, CGSizeZero))
        size = CGSizeMake(64.0, 64.0);

    NSAttributedString *iconString = [NSAttributedString symbolsetIconStringWithFont:font iconName:iconName size:12 color:[UIColor whiteColor]];
    CGRect iconRect = [iconString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    CGFloat fontSize = size.height * (12.0 / iconRect.size.height);
    UIFont *iconFont = [UIFont fontWithSymbolsetFontNamed:font size:fontSize];

    NSString *identifier = [NSString stringWithFormat:@"%@_%@_%0.2f", iconName, iconFont.fontName, fontSize];

    UIImage *image = [_ssIconCache objectForKey:identifier];
    if (!image)
    {
        iconString = [NSAttributedString symbolsetIconStringWithFont:font iconName:iconName size:fontSize color:[UIColor whiteColor]];
        CGSize iconSize = [iconString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        iconSize.width  = ceil(iconSize.width);
        iconSize.height = ceil(iconSize.height);

        if (!CGSizeEqualToSize(CGSizeZero, iconSize))
        {
            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0);
            [iconString drawAtPoint:CGPointZero];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            [_ssIconCache setObject:image forKey:identifier];
        }
    }

    return image;
}

@end
