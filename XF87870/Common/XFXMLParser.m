//
//  XFXMLParser.m
//  XF87870
//
//  Created by xf on 2016/11/24.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//



#import "XFXMLParser.h"
@interface XFXMLParser()
@property (strong, nonatomic) NSXMLParser *parser;
@property (copy, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSMutableArray *result;
@property (strong, nonatomic) NSMutableString *mutableString;
@end
@implementation XFXMLParser

- (instancetype)initWithNSData:(NSData*)data{
    if (self = [super init]) {
        self.parser = [[NSXMLParser alloc]initWithData:data];
        self.parser.delegate = self;
        self.result = [NSMutableArray new];
        self.mutableString = [NSMutableString new];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
    attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"img"]) {
        NSString *imgUrl = [attributeDict objectForKey:@"src"];
        NSDictionary *dic = @{@"img":imgUrl};
        [self.result addObject:dic];
    }else if([elementName isEqualToString:@"embed"]){
        NSDictionary *dic = @{@"video":@"video"};
        [self.result addObject:dic];
    }else if([self.currentElement isEqualToString:@"p"] && [elementName isEqualToString:@"br"]){
        NSDictionary *dic = @{@"br":@"br"};
        [self.result addObject:dic];
    }
    self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([self.currentElement isEqualToString:@"p"] ||
        [self.currentElement isEqualToString:@"span"] ||
        [self.currentElement isEqualToString:@"a"] ||
        [self.currentElement isEqualToString:@"h1"]) {
        [self.mutableString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if ([elementName isEqualToString:@"p"] && self.mutableString.length > 0) {
        NSDictionary *dic = @{@"text":self.mutableString.copy};
        self.mutableString = nil;
        self.mutableString = [NSMutableString new];
        [self.result addObject:dic];
    }
}

- (NSArray*) parse
{
    [self.parser parse];
    return self.result;
}


@end
