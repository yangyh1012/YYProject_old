//
//  YYTestData.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYTestData.h"

@implementation YYTestData

static NSString *idd = @"idd";
static NSString *testId = @"testId";

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.idd = [aDecoder decodeObjectForKey:idd];
        self.testId = [aDecoder decodeObjectForKey:testId];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.idd forKey:idd];
    [aCoder encodeObject:self.testId forKey:testId];
}

MJExtensionLogAllProperties

@end
