//
//  NSObject+ModelToDictionary.h
//  iCarService
//
//  Created by hefei on 2017/11/23.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelToDictionary)
/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary *_Nullable)dictionaryFromModel;
/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
- (id _Nullable )idFromObject:(nonnull id)object;
@end
