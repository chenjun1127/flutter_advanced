import 'dart:math';
import 'dart:ui';

class ColorUtils {
  static Color getColorFromGradient(double value, List<Color> colors, List<double> stops) {
    assert(value >= 0.0 && value <= 1.0, 'Value must be between 0 and 1');
    assert(colors.length == stops.length, 'Colors and stops must have the same length');
    for (int i = 0; i < stops.length - 1; i++) {
      if (value >= stops[i] && value <= stops[i + 1]) {
        final double t = (value - stops[i]) / (stops[i + 1] - stops[i]);
        return Color.lerp(colors[i], colors[i + 1], t)!;
      }
    }
    return colors.first;
  }

  static Color generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // 固定不透明度为 255
      random.nextInt(256), // 0-255 随机生成红色值
      random.nextInt(256), // 0-255 随机生成绿色值
      random.nextInt(256), // 0-255 随机生成蓝色值
    );
  }
}
