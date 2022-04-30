//
//  ViewController.m
//  GCDSemaphoreQueue
//
//  Created by LeiXiang on 2022/2/9.
//

#import "ViewController.h"


static void *const kGlobalIdentifyKey = (void *)&kGlobalIdentifyKey;
@interface ViewController ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_group_t group;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  _semaphore = dispatch_semaphore_create(10);
  _group = dispatch_group_create();
  _queue = dispatch_queue_create("com.lx.demo", DISPATCH_QUEUE_CONCURRENT);
  void *nonnullvalue = kGlobalIdentifyKey;
  dispatch_queue_set_specific(_queue, kGlobalIdentifyKey, nonnullvalue, NULL);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 ///外部没有在_queue上执行
  [self testWithoutQueue];
//  ///外部在_queue上执行
//  [self testWithQueue];
//  ///block方式的group操作，wait也有阻塞作用
//  [self testGroup];
}

///外部没有在_queue队列上执行
///内部会在dispatch到_queue队列上执行，这样就会10个一组并发执行
- (void)testWithoutQueue {
  for (NSInteger i = 0; i < 100; i++) {
    
    void (^block)(void) = ^ {
      dispatch_semaphore_wait(self->_semaphore, DISPATCH_TIME_FOREVER);
      [NSThread sleepForTimeInterval:0.4];
      NSLog(@"%zi",i);
      dispatch_semaphore_signal(self->_semaphore);
    };
    if (dispatch_get_specific(kGlobalIdentifyKey)) {
      block();
      NSLog(@"直接执行block");
    } else {
//      NSLog(@"dispatch 执行block");
      dispatch_async(self->_queue, block);
    }
//    NSLog(@"循环中的final line");
  }
}

///外部在_queue队列上执行
///内部判断了是在该队列上，就直接执行，这也使得循环是串行的
- (void)testWithQueue {
  dispatch_async(_queue, ^{
    for (NSInteger i = 0; i < 100; i++) {
      void (^block)(void) = ^ {
        dispatch_semaphore_wait(self->_semaphore, DISPATCH_TIME_FOREVER);
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"%zi",i);
        dispatch_semaphore_signal(self->_semaphore);
      };
      if (dispatch_get_specific(kGlobalIdentifyKey)) {
        block();
        NSLog(@"直接执行block");
      } else {
        NSLog(@"dispatch 执行block");
        dispatch_async(self->_queue, block);
        
      }
      
      
    }
  });
}


//dispatch_group_wait在block方法也适用
//打印完0-9后才打印After group wait
- (void)testGroup {
  for (NSInteger i = 0; i < 10; i++) {
    dispatch_group_async(_group, _queue, ^{
      [NSThread sleepForTimeInterval:0.2];
      NSLog(@"%zi",i);
    });
  }
  dispatch_group_wait(_group, DISPATCH_TIME_FOREVER);
  NSLog(@"After group wait");
}


@end
