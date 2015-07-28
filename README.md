# CFGradientLabelDemo
实现文字渐变色的两种方法
===========================
效果如下:

![image](https://github.com/yuchuanfeng/CFGradientLabelDemo/blob/master/iOS%20Simulator%20Screen%20Shot%202015%E5%B9%B47%E6%9C%8828%E6%97%A5%20%E4%B8%8A%E5%8D%8811.36.44.png?raw=true)

其实这两种方法实现原理及思路是差不多的, 只是使用的类和方法不一样.

　　(一)_ 自定义label, 实现 drawRect 方法, 在该方法里面画渐变色
-----------------------------------------

###　思路:
### 　　   1)_ 把label的文字画到context上去(画文字的作用主要是设置 layer 的mask)
     CGContextRef context = UIGraphicsGetCurrentContext();

      [self.textColor set];

      [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:NULL];

###　　　　2)_ 设置mask : CGContextClipToMask(context, rect, alphaMask); 并清除文字

    CGContextTranslateCTM(context, 0.0f, rect.size.height- (rect.size.height - textSize.height)*0.5);

    CGContextScaleCTM(context, 1.0f, -1.0f);

    

    CGImageRef alphaMask = NULL;

    alphaMask = CGBitmapContextCreateImage(context);

    CGContextClearRect(context, rect);// 清除之前画的文字

    CGContextClipToMask(context, rect, alphaMask);

###　　　3)_ 翻转坐标, 画渐变色

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, NULL);

    CGPoint startPoint = CGPointMake(textRect.origin.x,textRect.origin.y);

    CGPoint endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height);

    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    

    // 释放内存

    CGColorSpaceRelease(colorSpace);

    CGGradientRelease(gradient);

    CFRelease(alphaMask);

 

　　(二)_ 不需要自定义label, 利用 CAGradientLayer 设置渐变图层
-------------------

### 思路: 
###　　  1)_ 新建label, 把label添加到view上(这个label图层作用也只是设置mask, 不用来显示)

###　　  2)_ 创建 CAGradientLayer, 设置其渐变色, 将其添加到 label 的superView的layer上, 并覆盖在label上

###　　  3)_ 设置 gradientLayer的mask为 label的layer 重新设置label的frame

