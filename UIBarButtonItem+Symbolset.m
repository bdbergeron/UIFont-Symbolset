//
//  UIBarButtonItem+Symbolset.m
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
#import "UIBarButtonItem+Symbolset.h"


#pragma mark -
@implementation UIBarButtonItem (Symbolset)

+ (instancetype)bdb_barButtionItemWithSymbolsetIconName:(NSString *)iconName
                                                   font:(SSFontName)font
                                                  color:(UIColor *)color
                                                 target:(id)target
                                                 action:(SEL)action {
    UIBarButtonItem *button = [[[self class] alloc] initWithTitle:iconName
                                                            style:UIBarButtonItemStylePlain
                                                           target:target
                                                           action:action];

    CGFloat defaultfontSize = [[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] pointSize];
    UIColor *defaultColor = color;

    NSDictionary *attributes = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal];

    if (attributes) {
        defaultfontSize = [(UIFont *)attributes[NSFontAttributeName] pointSize];
        defaultColor = attributes[NSForegroundColorAttributeName];
    }

    NSAttributedString *iconString = [NSAttributedString bdb_symbolsetIconStringWithFont:font
                                                                                iconName:iconName
                                                                                    size:defaultfontSize
                                                                                   color:defaultColor];
    NSRange range = NSMakeRange(0, iconString.length);
    attributes = [iconString attributesAtIndex:0 effectiveRange:&range];

    [button setTitleTextAttributes:attributes forState:UIControlStateNormal];

    return button;
}

@end
