**主流转场动画**

**2019/07/19 push增加卡片效果**  
![121212.gif](https://upload-images.jianshu.io/upload_images/1801563-f6793ea51c9453e6.gif?imageMogr2/auto-orient/strip)

---

![1.gif](https://upload-images.jianshu.io/upload_images/1801563-7c7f0def50ca8269.gif?imageMogr2/auto-orient/strip)![2.gif](https://upload-images.jianshu.io/upload_images/1801563-f5d8172f7c7828d7.gif?imageMogr2/auto-orient/strip)

![3.gif](https://upload-images.jianshu.io/upload_images/1801563-348ead15ab2669d3.gif?imageMogr2/auto-orient/strip)![4.gif](https://upload-images.jianshu.io/upload_images/1801563-6470fad4670f7667.gif?imageMogr2/auto-orient/strip)

![5.gif](https://upload-images.jianshu.io/upload_images/1801563-050c35c20e37dc17.gif?imageMogr2/auto-orient/strip)![6.gif](https://upload-images.jianshu.io/upload_images/1801563-593d5fdefc759f97.gif?imageMogr2/auto-orient/strip)

![7.gif](https://upload-images.jianshu.io/upload_images/1801563-b8d20580229e1769.gif?imageMogr2/auto-orient/strip)

**2018-05-17增加CATransition动画**

![transitionCube.gif](https://upload-images.jianshu.io/upload_images/1801563-061c95cfd7d776d1.gif?imageMogr2/auto-orient/strip)![transitionCurl.gif](https://upload-images.jianshu.io/upload_images/1801563-81247a4213d193ca.gif?imageMogr2/auto-orient/strip)

![transitionOgl.gif](https://upload-images.jianshu.io/upload_images/1801563-5730903fa2d97c10.gif?imageMogr2/auto-orient/strip)![transitionRipple.gif](https://upload-images.jianshu.io/upload_images/1801563-e077c0e8ff06b09d.gif?imageMogr2/auto-orient/strip)

![transitionSuck.gif](https://upload-images.jianshu.io/upload_images/1801563-7f659c63c9731968.gif?imageMogr2/auto-orient/strip)

**使用方法**
>1、导入头文件`UIViewController+HHTransition`

>2、调用如下方法，基本只需要一句话，无侵入，API简单易用

```objc
        case 0:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentCircleVC:circleVC point:_touchPoint completion:nil];
        }
            break;
        case 1://内部只做背部控制器动画，前台动画自己控制
            [self hh_presentVC:[BackScaleViewController new] type:AnimationStyleBackScale completion:nil];
            break;
        case 2:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentVC:circleVC type:AnimationStyleErect completion:nil];
        }
            break;
        case 3:{//需要重写 hh_transitionAnimationView
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentVC:circleVC type:AnimationStyleTilted completion:nil];
        }
            break;
        case 4:{//需要重写 hh_transitionAnimationView
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"1.jpg"];
            [self.navigationController hh_pushViewController:interScale style:AnimationStyleScale];
        }
            break;
        case 5:{
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"2.jpg"];
            [self.navigationController hh_pushViewController:interScale style:AnimationStyleScale];
        }
            break;
        case 6:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleErect];
            break;
        case 7:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleTilted];
            break;
        case 8:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleBack];
            break;
        case 9:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleCube];
            break;
        case 10:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleSuckEffect];
            break;
        case 11:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleOglFlip];
            break;
        case 12:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleRippleEffect];
            break;
        case 13:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStylePageCurl];
            break;
        case 14:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleCameralIrisHollowOpen];
            break;
        case 15:
            [self.navigationController hh_pushViewController:[TopBackViewController new] style:AnimationStyleTopBack];
            break;
```

**支持cocoapod**

```objc
target 'MyApp' do
  pod 'HHTransition', '~> 2.0.0'
end
```

