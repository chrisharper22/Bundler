//
//  CoreServices.m
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//

#import <Foundation/Foundation.h>
#import "CoreServices.h"

@implementation LSApplicationProxy (Bundler)
- (NSString *)LHIdentifier {
    if ([self respondsToSelector:@selector(_boundApplicationIdentifier)])
        return [self _boundApplicationIdentifier];
    return [self applicationIdentifier];
}
@end
