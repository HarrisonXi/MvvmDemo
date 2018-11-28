//
//  EZSOrderedSet.h
//  EasySequence
//
//  Created by William Zang on 2018/4/20.
//

#import <Foundation/Foundation.h>
#import <EasySequence/EZSTransfer.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZSOrderedSet<__covariant T> : NSObject <NSFastEnumeration, NSCopying, EZSTransfer>

/**
 The number of objects in the orderedset.
 */
@property (readonly) NSUInteger count;

- (instancetype)initWithNSArray:(NSArray<T> *)array;
- (instancetype)initWithNSOrderedSet:(NSOrderedSet<T> *)set NS_DESIGNATED_INITIALIZER;

/**
 Returns a Boolean value that indicates whether a given object is present in the array.
 */
- (BOOL)containsObject:(T)anObject;

/**
 Returns the object located at the specified index.
 */
- (T)objectAtIndex:(NSUInteger)index;

/**
 Inserts a given object at the end of the orderedset.

 @param anObject    The object to add to the end of the orderedset’s content. This value must not be `nil`
 */
- (void)addObject:(T)anObject;

/**
 Inserts a given object into the orderedset’s contents at a given index.

 @param anObject    The object to add to the orderedset’s content. This value must not be `nil`
 @param index       The index in the orderedset at which to insert `anObject`. This value must not be greater than the count of elements in the orderedset
 */
- (void)insertObject:(T)anObject atIndex:(NSUInteger)index;

/**
 Removes the last object of the orderedset.
 */
- (void)removeLastObject;

/**
 Removes the first object of the orderedset.
 */
- (void)removeFirstObject;

/**
 Removes the object at the specified index.

 @param index    The index from which to remove the object in the orderedset. The value must not exceed the bounds of the orderedset
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 Removes the specified object.

 @param anObject The object to remove from the orderedset. This value must not be 'nil'
 */
- (void)removeObject:(T)anObject;

/** 
 Removes all the objects of the orderedset. 
 */
- (void)removeAllObjects;

/**
 Replaces the object at `index` with `anObject`.

 @param index       The index of the object to be replaced. This value must not exceed the bounds of the orderedset.
 @param anObject    The object with which to replace the object at the index in the orderedset. This value must not be nil.
 */
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(T)anObject;

/**
 Return all objects in the orderedset as a NSArray.
 */
- (NSArray<T> *)allObjects;

/**
 Replaces the object at the index with the new object, possibly adding the object.

 @param obj    The object with which to replace the object at the index in the orderedset. This value must not be `nil`
 @param idx    The index of the object to be replaced. This value must not exceed the bounds of the orderedset
 */
- (void)setObject:(T)obj atIndexedSubscript:(NSUInteger)idx;

/**
 Returns the object at the specified index.

 @param index    An index within the bounds of the orderedset
 @return         The object located at `index`
 */
- (T)objectAtIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
