//
//  UIKit+Bundler.h
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//  Copyright © 2021 Simalary (Chris). All rights reserved.
//

#ifndef UIKit_Bundler_h
#define UIKit_Bundler_h

#import <UIKit/UIKit.h>

@interface UIImage (Bundler)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3; //chnage

+ (id)_iconForResourceProxy:(id)arg1 format:(int)arg2;
+ (id)_iconForResourceProxy:(id)arg1 variant:(int)arg2 variantsScale:(double)arg3;
+ (int)_iconVariantForUIApplicationIconFormat:(int)arg1 scale:(double*)arg2;

@end

#endif /* UIKit_Bundler_h */
