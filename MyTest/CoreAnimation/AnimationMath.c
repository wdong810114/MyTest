//
//  AnimationMath.c
//  MyTest
//
//  Created by wangdongdong on 16/6/20.
//  Copyright © 2016年 Spark. All rights reserved.
//

#include "AnimationMath.h"

float bounceEaseOut(float t)
{
    if(t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if(t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if(t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}