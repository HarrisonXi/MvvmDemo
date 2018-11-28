//
//  EZSArray.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <Foundation/Foundation.h>
#import <EasySequence/EZSTransfer.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZSArray<__covariant T> : NSObject <NSFastEnumeration, NSCopying, EZSTransfer>

/**
 The number of objects in the array.
 */
@property (readonly) NSUInteger count;

- (instancetype)initWithNSArray:(NSArray<T> *)array NS_DESIGNATED_INITIALIZER;

/**
 Returns a Boolean value that indicates whether a given object is present in the array.
 */
- (BOOL)containsObject:(T)anObject;

/**
 Returns the lowest index whose corresponding array value is equal to a given object
 */
- (NSUInteger)indexOfObject:(T)anObject;

/**
 Returns the object located at the specified index.
 */ 
- (nullable T)objectAtIndex:(NSUInteger)index;

/**
 Inserts a given object at the end of the array.

 @param anObject    The object to add to the end of the array’s content. This value must not be `nil`
 */
- (void)addObject:(T)anObject;

/**
 Inserts a given object into the array’s contents at a given index.

 @param anObject    The object to add to the array's content. This value must not be `nil`
 @param index       The index in the array at which to insert `anObject`. This value must not be greater than the count of elements in the array
 */
- (void)insertObject:(T)anObject atIndex:(NSUInteger)index;

/**
 Removes the last object of the array. 
 */
- (void)removeLastObject;

/**
 Removes the first object of the array.
 */
- (void)removeFirstObject;

/**
 Removes the specified object.

 @param anObject The object to remove from the array. This value must not be 'nil'
 */
- (void)removeObject:(T)anObject;

/**
 Removes all the objects of the array.
 */
- (void)removeAllObjects;

/**
 Removes the object at the specified index.

 @param index    The index from which to remove the object in the array. The value must not exceed the bounds of the array
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 Replaces the object at `index` with `anObject`.

 @param index       The index of the object to be replaced. This value must not exceed the bounds of the array.
 @param anObject    The object with which to replace the object at the index in the array. This value must not be nil.
 */
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(T)anObject;

/**
 Converts to NSArray.
 */
- (nonnull NSArray<T> *)toArray;

/**
 Replaces the object at the index with the new object, possibly adding the object.

 @param obj    The object with which to replace the object at index index in the array. This value must not be `nil`
 @param idx    The index of the object to be replaced. This value must not exceed the bounds of the array
 */
- (void)setObject:(T)obj atIndexedSubscript:(NSUInteger)idx;

/**
 Returns the object at the specified index.

 @param index    An index within the bounds of the array
 @return         The object located at `index`
 */
- (T)objectAtIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
