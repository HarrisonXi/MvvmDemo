/**
 * Beijing Sankuai Online Technology Co.,Ltd (Meituan)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

#import "EZRPerformSelectorListen.h"
#import <objc/runtime.h>

@implementation EZRPerformSelectorListen {
    SEL _selector;
}

- (instancetype)initWithSelector:(SEL)selector {
    NSParameterAssert(selector);
    if (self = [super init]) {
        _selector = selector;
    }
    return self;
}

- (void)next:(id)value from:(EZRSenderList *)senderList context:(nullable id)context {
    NSMethodSignature *signature = [self.to methodSignatureForSelector:_selector];
    NSAssert(signature, @"the selector %s does exists!", sel_getName(_selector));
    if (signature == nil) {
        return;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    switch (signature.numberOfArguments) {
        case 2: // self, _cmd no parameter
            [self.to performSelector:_selector];
            break;
        case 3: // self, _cmd, id value
            NSAssert(strcmp("@", [signature getArgumentTypeAtIndex:2]) == 0, @"the selector %s must have id parameter!", sel_getName(_selector));
            [self.to performSelector:_selector withObject:value];
            break;
        case 4: // self, _cmd, id value, id context
            NSAssert(strcmp("@", [signature getArgumentTypeAtIndex:2]) == 0, @"the selector %s must have id parameter!", sel_getName(_selector));
            NSAssert(strcmp("@", [signature getArgumentTypeAtIndex:3]) == 0, @"the selector %s must have id parameter!", sel_getName(_selector));
            [self.to performSelector:_selector withObject:value withObject:context];
            break;
        default:
            NSAssert(false, @"the selector %s 's parameters count isn't 0, 1 or 2!", sel_getName(_selector));
            break;
    }
#pragma clang diagnostic pop
}

@end
