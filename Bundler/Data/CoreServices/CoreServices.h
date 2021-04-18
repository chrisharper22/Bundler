//
//  CoreServices.h
//  Bundler
//
//  Created by Chris Harper on 4/14/21.
//

#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>

#ifndef CoreServices_h
#define CoreServices_h

@interface LSApplicationProxy : NSObject
- (nullable NSURL *)bundleURL;
- (nullable NSString *)localizedName;
- (nullable NSString *)applicationIdentifier;
- (nullable NSString *)_boundApplicationIdentifier;
- (nullable NSString *)shortVersionString;
- (nullable NSString *)bundleExecutable;
- (nullable NSString *)applicationType;
- (nullable NSString *)signerIdentity;
- (nullable NSArray *)UIBackgroundModes;
- (nullable NSURL *)dataContainerURL;
- (nullable NSString *)LHIdentifier;
- (nullable NSDictionary *)entitlements;
@end

@interface LSApplicationWorkspace : NSObject
+ (nonnull instancetype)defaultWorkspace;
- (bool)openApplicationWithBundleID:(nullable NSString *)bundleID;
- (nonnull NSArray<LSApplicationProxy *> *)allInstalledApplications;
@end

#endif /* CoreServices_h */
