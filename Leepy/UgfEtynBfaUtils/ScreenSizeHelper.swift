import SwiftUI
import UIKit

// 1. 设计尺寸配置
public struct DesignSize: Equatable {
  public let width: CGFloat
  public let height: CGFloat

  public init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }

  // 为兼容 dg/dm 缩放
  public var magnitude: CGFloat {
    sqrt(width * width + height * height)
  }
}

// 2. ScreenUtil：不使用 actor（iOS 屏幕配置无需并发）
public class ScreenUtil {
  public static let shared = ScreenUtil()

  public var designSize: DesignSize = DesignSize(width: 375, height: 812)
  public private(set) var currentSize: CGSize = .zero
  public private(set) var screenScale: CGFloat = 1.0

  private init() {
    updateSize()
    screenScale = UIScreen.main.scale
  }

  /// 读取当前设备尺寸（在 App 启动后调用）
  public func updateSize() {
    currentSize = UIScreen.main.bounds.size
  }

  // MARK: - 核心缩放因子

  /// 按宽度比例缩放（推荐）
  public var widthScale: CGFloat {
    guard currentSize.width > 0 else { return 1 }
    return currentSize.width / designSize.width
  }

  /// 按高度比例缩放
  public var heightScale: CGFloat {
    guard currentSize.height > 0 else { return 1 }
    return currentSize.height / designSize.height
  }

  /// 对角线比例（用于dg/dm）
  public var diagonalScale: CGFloat {
    let currentMag = currentSize.magnitude
    let designMag = designSize.magnitude
    return currentMag / designMag
  }

  // MARK: - API 方法

  public func setWidth(_ value: CGFloat) -> CGFloat { value * widthScale }
  public func setHeight(_ value: CGFloat) -> CGFloat { value * heightScale }
  public func setSp(_ value: CGFloat) -> CGFloat {
    // ⚠️ 建议仅作备用；主推用 @ScaledMetric 或 .scaledFont()
    return value * widthScale
  }

  // flutter 中的 radius/diameter/diagonal 缩放
  public func radius(_ value: CGFloat) -> CGFloat {
    // 半径缩放 ≈ 宽度比例（常用）
    value * widthScale
  }

  public func diameter(_ value: CGFloat) -> CGFloat {
    // 直径缩放 = 宽高较大者缩放
    let maxDim = max(currentSize.width, currentSize.height)
    let maxDesign = max(designSize.width, designSize.height)
    return value * (maxDim / maxDesign)
  }

  public func diagonal(_ value: CGFloat) -> CGFloat {
    value * diagonalScale
  }
}

// 扩展 CGSize 提供 magnitude（对角线长度）
extension CGSize {
  fileprivate var magnitude: CGFloat {
    sqrt(width * width + height * height)
  }
}

// 3. CGFloat 扩展：所有 .w/.h/.r/.dm/.dg/.sp 等
extension CGFloat {
  /// 按设计稿宽度比例缩放（推荐）
  public var w: CGFloat { ScreenUtil.shared.setWidth(self) }

  /// 按设计稿高度比例缩放（慎用）
  public var h: CGFloat { ScreenUtil.shared.setHeight(self) }

  /// 按半径缩放（兼容 flutter 中 r）
  public var r: CGFloat { ScreenUtil.shared.radius(self) }

  /// 按直径缩放
  public var dm: CGFloat { ScreenUtil.shared.diameter(self) }

  /// 按对角线缩放
  public var dg: CGFloat { ScreenUtil.shared.diagonal(self) }

  /// 字体 sp 缩放（⚠️ 仅用于兼容；主推用 @ScaledMetric）
  public var sp: CGFloat { ScreenUtil.shared.setSp(self) }

  // 借用方向命名：用于 EdgeInsets 的 leading/trailing
  /// 为 EdgeInsets 方向准备：leading 等价于 left，trailing 等价于 right
  public var leading: CGFloat { self }
  public var trailing: CGFloat { self }
  public var top: CGFloat { self }
  public var bottom: CGFloat { self }
}

// 4. EdgeInsets 扩展：提供 .r/.dm/.dg/.w/.h（对方向支持）
extension EdgeInsets {
  /// 所有边应用 r 缩放（兼容 flutter）
  public var r: EdgeInsets {
    EdgeInsets(
      top: top.r,
      leading: leading.r,
      bottom: bottom.r,
      trailing: trailing.r
    )
  }

  /// 直径缩放
  public var dm: EdgeInsets {
    EdgeInsets(
      top: top.dm,
      leading: leading.dm,
      bottom: bottom.dm,
      trailing: trailing.dm
    )
  }

  /// 对角线缩放
  public var dg: EdgeInsets {
    EdgeInsets(
      top: top.dg,
      leading: leading.dg,
      bottom: bottom.dg,
      trailing: trailing.dg
    )
  }
}
// 在您的扩展块末尾追加：
extension Int {
  public var w: CGFloat { CGFloat(self).w }
  public var h: CGFloat { CGFloat(self).h }
  public var r: CGFloat { CGFloat(self).r }
  public var dm: CGFloat { CGFloat(self).dm }
  public var dg: CGFloat { CGFloat(self).dg }
  public var sp: CGFloat { CGFloat(self).sp }
}

extension Double {
  public var w: CGFloat { CGFloat(self).w }
  public var h: CGFloat { CGFloat(self).h }
  public var r: CGFloat { CGFloat(self).r }
  public var dm: CGFloat { CGFloat(self).dm }
  public var dg: CGFloat { CGFloat(self).dg }
  public var sp: CGFloat { CGFloat(self).sp }
}
