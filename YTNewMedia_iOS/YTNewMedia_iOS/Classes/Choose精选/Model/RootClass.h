#import <Foundation/Foundation.h>
#import "Data.h"

@interface RootClass : NSObject

@property (nonatomic, strong) Data * data;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger success;

@end
