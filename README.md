###主流转场动画

![1.gif](https://upload-images.jianshu.io/upload_images/1801563-7c7f0def50ca8269.gif?imageMogr2/auto-orient/strip)

![2.gif](https://upload-images.jianshu.io/upload_images/1801563-f5d8172f7c7828d7.gif?imageMogr2/auto-orient/strip)

![3.gif](https://upload-images.jianshu.io/upload_images/1801563-348ead15ab2669d3.gif?imageMogr2/auto-orient/strip)

![4.gif](https://upload-images.jianshu.io/upload_images/1801563-6470fad4670f7667.gif?imageMogr2/auto-orient/strip)

![5.gif](https://upload-images.jianshu.io/upload_images/1801563-050c35c20e37dc17.gif?imageMogr2/auto-orient/strip)

![6.gif](https://upload-images.jianshu.io/upload_images/1801563-593d5fdefc759f97.gif?imageMogr2/auto-orient/strip)

![7.gif](https://upload-images.jianshu.io/upload_images/1801563-b8d20580229e1769.gif?imageMogr2/auto-orient/strip)

###使用方法
>1、导入头文件`UIViewController+HHTransition`
>2、调用如下方法，基本只需要一句话，无侵入，API简单易用

```objc
        case 0:
            [self.navigationController hh_presentCircleVC:[CircleViewController new] point:_touchPoint completion:nil];
            break;
        case 1:
            [self.navigationController hh_presentBackScaleVC:[BackScaleViewController new] height:400 completion:nil];
            break;
        case 2:
            [self.navigationController hh_presentErectVC:[CircleViewController new] completion:nil];
            break;
        case 3:{//需要重写 hh_transitionAnimationView
           InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"1.jpg"];
            [self.navigationController hh_pushScaleViewController:interScale];
        }
            break;
        case 4:{//需要重写 hh_transitionAnimationView
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"2.jpg"];
            [self.navigationController hh_pushScaleViewController:interScale];
        }
            break;
        case 5:
            [self.navigationController hh_pushTiltViewController:[CircleViewController new]];
            break;
        case 6:
            [self.navigationController hh_pushErectViewController:[CircleViewController new]];
            break;
        case 7:
            [self.navigationController hh_pushBackViewController:[CircleViewController new]];
            break;
        default:
            break;
```

###支持cocoapod

```objc
target 'MyApp' do
  pod 'HHTransition', '~> 1.0'
end
```

