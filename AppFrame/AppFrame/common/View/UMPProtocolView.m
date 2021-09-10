//
//  UMPProtocolView.m
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/10.
//  Copyright © 2021 UMP. All rights reserved.
//

#import "UMPProtocolView.h"
#import "Masonry.h"

@interface UMPProtocolView ()<UITextViewDelegate>
@property (nonatomic, strong, readwrite) UMPNoMenuTextView *textView;
@end

@implementation UMPProtocolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    self.textView = [[UMPNoMenuTextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textView];
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_greaterThanOrEqualTo(0);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setProtocolModel:(UMPProtocolModel *)protocolModel {
    _protocolModel = protocolModel;
    if (protocolModel == nil) {
        return;
    }
    UITextField *textField ;
    
    
//    NSArray *items = protocolModel.items;
//    UMPProtocolBox *box = protocolModel.box;
//    
//    NSMutableAttributedString *attributesStr = [[NSMutableAttributedString alloc] init];
//    
//    if (box) {
//        NSAttributedString *boxAttrStr = [self attributeStrWithBox:box];
//        if (boxAttrStr) {
//            [attributesStr appendAttributedString:boxAttrStr];
//            [attributesStr addAttributes:@{NSLinkAttributeName:@"box://"} range:NSMakeRange(0, boxAttrStr.length)];
//        }
//    }
//    [attributesStr appendString:@" "];
//    for (NSInteger i = 0; i < items.count;i++) {
//        UMPProtocolItem *item = items[i];
//        NSAttributedString *protocolAttriStr = [self attributeStrWithItem:item];
//        if (protocolAttriStr == nil) {
//            continue;
//        }
//        [attributesStr appendAttributedString:protocolAttriStr];
//        NSString *linkName = [NSString stringWithFormat:@"protocol_%ld://",(long)i];
//        NSRange range = [attributesStr.string rangeOfString:item.nameWithsymbol];
//        [attributesStr addAttributes:@{NSLinkAttributeName:linkName} range:range];
//    }
//    NSMutableParagraphStyle *muParagraph = [[NSMutableParagraphStyle alloc]init];
//        muParagraph.headIndent = 18; //
//    muParagraph.lineSpacing = 6;
//    [attributesStr setAttribute:NSParagraphStyleAttributeName value:muParagraph];
//    self.textView.attributedText = attributesStr;
}

///box模型转属性文字
- (NSAttributedString *)attributeStrWithBox:(UMPProtocolBox *)box {
    if (box == nil) {
        return nil;
    }
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    NSString *imageName = box.selected ? box.selectImageName : box.imageName;
    attach.image = [UIImage imageNamed:imageName];
    attach.bounds = CGRectMake(0, -2, 15, 15);
    return [NSAttributedString attributedStringWithAttachment:attach];
}

///协议item转属性文字
- (NSAttributedString *)attributeStrWithItem:(UMPProtocolItem *)item {
    if (item == nil || item.name.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    if (item.preDes.length) {
        NSDictionary *attribute = @{NSForegroundColorAttributeName:item.preDesColor,NSFontAttributeName:[UIFont systemFontOfSize:item.fontSize]};
        NSAttributedString *preAtt = [[NSAttributedString alloc] initWithString:item.preDes attributes:attribute];
        [attributeStr appendAttributedString:preAtt];
    }
    NSDictionary *attribute = @{NSForegroundColorAttributeName:item.protocolColor,NSFontAttributeName:[UIFont systemFontOfSize:item.fontSize]};
    NSAttributedString *preAtt = [[NSAttributedString alloc] initWithString:item.nameWithsymbol attributes:attribute];
    [attributeStr appendAttributedString:preAtt];
    return [attributeStr copy];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    
    if ([URL.absoluteString containsString:@"box"] && self.boxClick) {
        self.boxClick(!self.protocolModel.box.selected);
    } else if ([URL.absoluteString containsString:@"protocol"] && self.prorotolClick) {
        NSString *str = [URL.absoluteString componentsSeparatedByString:@"_"].lastObject;
        str = [str componentsSeparatedByString:@":"].firstObject;
        if (str.length == 0) {
            return NO;
        }
        
        NSInteger index = str.integerValue;
        if (self.protocolModel.items.count <= index) {
            return NO;
        }
        
        UMPProtocolItem *item = self.protocolModel.items[index];
        self.prorotolClick(item);
    }
    
    return NO;
}


@end
