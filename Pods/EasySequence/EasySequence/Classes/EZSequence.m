//
//  EZSequence.m
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import "EZSequence.h"
#import "EZSBlockDefines.h"
#import "EZSTransfer.h"
#import "EZSEnumerator.h"
#import "EZSequence+ProjectPrivate.h"

@implementation EZSequence

- (instancetype)initWithOriginSequence:(id<NSFastEnumeration>)originSequence {
    NSParameterAssert(originSequence);
    if (self = [super init]) {
        _originSequence = originSequence;
    }
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(nonnull NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained * _Nonnull)buffer count:(NSUInteger)len {
    return [self.originSequence countByEnumeratingWithState:state objects:buffer count:len];
}

- (id)as:(Class)clazz {
    if ([(id)self.originSequence isMemberOfClass:clazz]) {
        return self.originSequence;
    }
    // NSArray specializations.
    if (clazz == NSArray.class && [(id)self.originSequence isKindOfClass:clazz]) {
        return [(id)self.originSequence copy];
    }
    NSParameterAssert([clazz conformsToProtocol:@protocol(EZSTransfer)]);
    return [clazz transferFromSequence:self];
}

- (NSEnumerator *)objectEnumerator {
    if ([(id)self.originSequence respondsToSelector:@selector(objectEnumerator)]) {
        return [(id)self.originSequence objectEnumerator];
    }
    return [[EZSEnumerator alloc] initWithFastEnumerator:self.originSequence];
}

- (void)forEachWithIndexAndStop:(void (^NS_NOESCAPE)(id _Nonnull, NSUInteger, BOOL * _Nonnull))eachBlock {
    NSParameterAssert(eachBlock);
    if (!eachBlock) { return; }
    NSUInteger index = 0;
    BOOL stop = NO;
    for (id item in self.originSequence) {
        eachBlock(item, index++, &stop);
        if (stop) {
            break;
        }
    }
}

- (BOOL)isEqual:(id)object {
    if (![[object class] conformsToProtocol:@protocol(NSFastEnumeration)]) {
        return NO;
    }
    if ([(id)self.originSequence isKindOfClass:[object class]]
        || [object isKindOfClass:[(id)self.originSequence class]]) {
        return [(id)self.originSequence isEqual:object];
    }
    NSEnumerator *selfEnumerator = [self objectEnumerator];
    NSEnumerator *otherEnumerator = nil;
    if ([object respondsToSelector:@selector(objectEnumerator)]) {
        otherEnumerator = [object objectEnumerator];
    } else {
        otherEnumerator = [[EZSEnumerator alloc] initWithFastEnumerator:object];
    }
    
    id leftValue = nil;
    id rightValue = nil;
    
    do {
        leftValue = [selfEnumerator nextObject];
        rightValue = [otherEnumerator nextObject];
        
        if (leftValue == rightValue || [leftValue isEqual:rightValue]) {
            continue;
        }
        return NO;
    } while (leftValue != nil);
    return YES;
}

- (NSString *)description {
    return [[self as:NSArray.class] description];
}

@end
