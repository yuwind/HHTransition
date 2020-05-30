**主流转场动画**

### 1、HHTransition优势
1、API只有两个方法，易调用<br/>
2、面向切面编程，无侵入，不需要在VC中设置代理<br/>
3、易扩展，只需要重写转场对象即可
### 2、HHTransition不足
1、不够灵活，对于同一个转场对象无法设置不同的转场时间<br/>
2、如果需要传参，需要通过协议传递，漏写协议，编译时无法发现问题
### 3、类图
![](https://upload-images.jianshu.io/upload_images/1801563-9c8cab90ab230e9d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 4、使用说明
#### 1、API使用
```objc
//present转场
- (void)hh_presentViewController:(UIViewController *)viewController presentStyle:(HHPresentStyle)presentStyle completion:(void (^__nullable)(void))completion
//push转场
- (void)hh_pushViewController:(UIViewController *)viewController style:(HHPushStyle)style;
```
例如：
```objc
[testViewController hh_presentViewController:viewController presentStyle:HHPresentStyleSlipFromTop completion:nil];
```
#### 2、扩展性
1、在`HHTransitionUtility`类下，增加枚举类型<br/>
2、增加转场对象，可以继承`HHBaseAnimatedTransition`，内部已做好分发<br/>
3、在类HHInteractionDelegate或者HHTransitioningDelegate下，根据枚举类型，设置transition对象<br/>
例如：
```objc
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    switch (presented.presentStyle) {
        case HHPresentStyleNone:
            return nil;
        case HHPresentStyleSlipFromTop:
        case HHPresentStyleSlipFromBottom:
        case HHPresentStyleSlipFromLeft:
        case HHPresentStyleSlipFromRight:
            return [HHPresentFlipTransition flipTransitionWithStyle:presented.presentStyle isBegining:YES];
        default:
            return nil;
    }
}
```
```objc
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (dismissed.presentStyle) {
        case HHPresentStyleNone:
            return nil;
        case HHPresentStyleSlipFromTop:
        case HHPresentStyleSlipFromBottom:
        case HHPresentStyleSlipFromLeft:
        case HHPresentStyleSlipFromRight:
            return [HHPresentFlipTransition flipTransitionWithStyle:dismissed.presentStyle isBegining:NO];
        default:
            return nil;
    }
}
```

**部分效果如下**  
![121212.gif](https://upload-images.jianshu.io/upload_images/1801563-f6793ea51c9453e6.gif?imageMogr2/auto-orient/strip)

---

![1.gif](https://upload-images.jianshu.io/upload_images/1801563-7c7f0def50ca8269.gif?imageMogr2/auto-orient/strip)![2.gif](https://upload-images.jianshu.io/upload_images/1801563-f5d8172f7c7828d7.gif?imageMogr2/auto-orient/strip)

![3.gif](https://upload-images.jianshu.io/upload_images/1801563-348ead15ab2669d3.gif?imageMogr2/auto-orient/strip)![4.gif](https://upload-images.jianshu.io/upload_images/1801563-6470fad4670f7667.gif?imageMogr2/auto-orient/strip)

![5.gif](https://upload-images.jianshu.io/upload_images/1801563-050c35c20e37dc17.gif?imageMogr2/auto-orient/strip)![6.gif](https://upload-images.jianshu.io/upload_images/1801563-593d5fdefc759f97.gif?imageMogr2/auto-orient/strip)

![7.gif](https://upload-images.jianshu.io/upload_images/1801563-b8d20580229e1769.gif?imageMogr2/auto-orient/strip)

**2018-05-17增加CATransition动画**
![transitionCube.gif](https://upload-images.jianshu.io/upload_images/1801563-061c95cfd7d776d1.gif?imageMogr2/auto-orient/strip)![transitionCurl.gif](https://upload-images.jianshu.io/upload_images/1801563-81247a4213d193ca.gif?imageMogr2/auto-orient/strip)

![transitionOgl.gif](https://upload-images.jianshu.io/upload_images/1801563-5730903fa2d97c10.gif?imageMogr2/auto-orient/strip)

<!--![transitionRipple.gif](https://upload-images.jianshu.io/upload_images/1801563-e077c0e8ff06b09d.gif?imageMogr2/auto-orient/strip)-->

<!--![transitionSuck.gif](https://upload-images.jianshu.io/upload_images/1801563-7f659c63c9731968.gif?imageMogr2/auto-orient/strip)
-->
**支持cocoapod**

```objc
target 'MyApp' do
  pod 'HHTransition', '~> 3.0.1'
end
```


