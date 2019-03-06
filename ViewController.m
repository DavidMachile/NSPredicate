//
//  ViewController.m
//  laoyouLive
//
//  Created by cctv-person on 2019/3/6.
//  Copyright © 2019 cctv-person. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     1.什么是NSPredicate
     apple官方文档这样写的: The NSPredicate class is used to define logical conditions used to constrain a search either for a fetch or for in-memory filtering.
     (NSPredicate类是通过定义逻辑条件来约束获取或内存中的过滤搜索。)
    
     2.基本语法  (大小写都可以，但是更推荐使用大写来表示这些保留字)
     只要我们使用谓词（NSPredicate）都需要为谓词定义谓词表达式,而这个表达式必须是一个返回BOOL的值。
     谓词表达式由表达式、运算符和值构成。如 SELF = 123
     
     
        (1) 比较运算符  = 和 == 没有赋值一说 都是判断是否相等
        (2) >=  <=  > < != <> 除此之外还有BETWEEN判定是否在之间
     */
    
   
    /*  符合条件之间范围的值  SELF>1  && SELF<10
        OR  ||  逻辑或 有一个满足就输出
        NOT !   逻辑非 取反
     */
    // between
    int testNumber = 4;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {1, 10}"];

    
    if ([predicate evaluateWithObject:[NSNumber numberWithInteger:testNumber]]) {
        NSLog(@"testString:%d", testNumber);
    } else {
        NSLog(@"不符合条件");
    }
    
    //(3)字符串比较运算符
    /*
        BEGINWITH 检查某字符是否以指定的字符串开头  eg: 是否以a开头  则为 BEGINSWITH 'a'
        ENDSWITH  以()为结尾
        CONTAINS  是否包含
        LIKE      检查某个字符串是否匹配指定的字符串模板,  其之后可以跟?和*两个通       配符   (?代表一个字符 *代表任意多个字符)
            eg: "name LIKE'?ac*'"  表示name的第2 3个字符是ac则返回YES
                "name LIKE'*ac*'"  表示name包含ac则返回YES
        MATCHES   检查某个字符串是否匹配指定的正则表达式
     */
    
    //(4)集合运算符
    /*
     ANY、SOME：集合中任意一个元素满足条件，就返回YES。
     ALL：集合中所有元素都满足条件，才返回YES。
     NONE：集合中没有任何元素满足条件就返回YES。如:NONE person.age < 18，表示person集合中所有元素的age>=18时，才返回YES。
     IN：等价于SQL语句中的IN运算符，只有当左边表达式或值出现在右边的集合中才会返回YES。
     
     
     array[index]：返回array数组中index索引处的元素
     array[FIRST]：返回array数组中第一个元素
     array[LAST]：返回array数组中最后一个元素
     array[SIZE]：返回array数组中元素的个数
     */
    
    /*
     二、NSPredicate 的用法
     (1) 定义谓词
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {1, 10}"];
     
     
     (2)(重难点模块)使用谓词过滤集合
        此部分是我们需要掌握的重点，因为从这里我们就可以看到谓词的真正的强大之处
        其实谓词本身就代表了一个逻辑条件，计算谓词之后返回的结果永远为BOOL类型的值。而谓词最常用的功能就是对集合进行过滤。
     
     
     ***************************重点*********************************

        当程序使用谓词对集合元素进行过滤时，程序会自动遍历其元素，并根据集合元素来计算谓词的值，当这个集合中的元素计算谓词并返回YES时，这个元素才会被保留下来。
     ***************************************************************
     ps:请注意程序会自动遍历其元素，它会将自动遍历过之后返回为YES的值重新组合成一个集合返回。
     */

    
    /*
    NSArray提供了如下方法使用谓词来过滤集合
    - (NSArray<ObjectType> *)filteredArrayUsingPredicate:(NSPredicate *)predicate:使用指定的谓词过滤NSArray集合，返回符合条件的元素组成的新集合
    
    NSMutableArray提供了如下方法使用谓词来过滤集合
    - (void)filterUsingPredicate:(NSPredicate *)predicate：使用指定的谓词过滤NSMutableArray，剔除集合中不符合条件的元素
    
    NSSet提供了如下方法使用谓词来过滤集合
    - (NSSet<ObjectType> *)filteredSetUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：作用同NSArray中的方法
    
    NSMutableSet提供了如下方法使用谓词来过滤集合
    - (void)filterUsingPredicate:(NSPredicate *)predicate NS_AVAILABLE(10_5, 3_0)：作用同NSMutableArray中的方法。
    通过上面的描述可以看出，使用谓词过滤不可变集合和可变集合的区别是：过滤不可变集合时，会返回符合条件的集合元素组成的新集合；过滤可变集合时，没有返回值，会直接剔除不符合条件的集合元素
    */
    
}

// 简单使用示例

// 判断手机号是否正确
- (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}

//检测字符串中是否有特殊字符
- (BOOL)checkSpecialCharacter:(NSString *)string
{
    NSString *regex = @"[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}
@end
