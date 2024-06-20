import 'dart:math';

class CalcUtils {
  // 计算两个数之间的随机数
  static double randomBetween(double min, double max) {
    return min + (max - min) * Random().nextDouble();
  }

  // 函数 mapValue，将数值 x 从一个范围 [oldMin, oldMax] 映射到新范围 [newMin, newMax]
  static double mapValue(double x, double oldMin, double oldMax, double newMin, double newMax) {
    return (x - oldMin) * (newMax - newMin) / (oldMax - oldMin) + newMin;
  }

  static double doubleToAngle(double angle) => angle * pi / 180.0;

  static double mapValueToRange(double x) {
    // 第一步：归一化值到 0-360
    double normalizedValue = x > 360 ? x - 360 : x;

    // 第二步：确保值在 245 到 475 的循环范围内
    // 如果值小于 245，我们需要加上 360 来进行循环
    if (normalizedValue < 245) {
      normalizedValue += 360;
    }

    // 第三步：调整到 0-230 的范围
    // 减去 245，得到一个范围在 0-230 的值
    final double adjustedValue = normalizedValue - 245;

    // 第四步：将值映射到 0-100 的范围
    final double mappedValue = (adjustedValue / 230) * 100;

    return mappedValue;
  }
}
