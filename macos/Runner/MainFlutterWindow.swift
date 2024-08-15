import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    // 创建 Flutter 视图控制器
    let flutterViewController = FlutterViewController.init()

    // 获取当前窗口的框架（尺寸和位置）
    let windowFrame = self.frame

    // 设置窗口的内容视图控制器为 Flutter 视图控制器
    self.contentViewController = flutterViewController

    // 设置窗口的框架（尺寸和位置）
    self.setFrame(windowFrame, display: true)

    // 设置窗口的内容大小
    self.setContentSize(NSSize(width: 1024, height: 600))

    // 设置窗口背景颜色
    self.backgroundColor = NSColor.black

    // 移除窗口的可调整大小功能
    self.contentView?.window?.styleMask.remove(.resizable)

    // 注册插件
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
