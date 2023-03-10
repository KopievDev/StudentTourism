// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal static let app = ImageAsset(name: "app")
    internal static let bookTab = ImageAsset(name: "book_tab")
    internal static let calendar = ImageAsset(name: "calendar")
    internal static let checked = ImageAsset(name: "checked")
    internal static let coffee = ImageAsset(name: "coffee")
    internal static let cup = ImageAsset(name: "cup")
    internal static let dacha = ImageAsset(name: "dacha")
    internal static let download = ImageAsset(name: "download")
    internal static let edu = ImageAsset(name: "edu")
    internal static let exit = ImageAsset(name: "exit")
    internal static let favTab = ImageAsset(name: "fav_tab")
    internal static let filter = ImageAsset(name: "filter")
    internal static let geo = ImageAsset(name: "geo")
    internal static let global = ImageAsset(name: "global")
    internal static let heart = ImageAsset(name: "heart")
    internal static let imgDacha = ImageAsset(name: "img_dacha")
    internal static let imgKurskCell = ImageAsset(name: "img_kursk_cell")
    internal static let imgMoscowCell = ImageAsset(name: "img_moscow_cell")
    internal static let imgTemplate = ImageAsset(name: "img_template")
    internal static let imgValskCell = ImageAsset(name: "img_valsk_cell")
    internal static let mail = ImageAsset(name: "mail")
    internal static let mainTab = ImageAsset(name: "main_tab")
    internal static let map = ImageAsset(name: "map")
    internal static let medalGold = ImageAsset(name: "medal_gold")
    internal static let microscope = ImageAsset(name: "microscope")
    internal static let notifyTab = ImageAsset(name: "notify_tab")
    internal static let phone = ImageAsset(name: "phone")
    internal static let profileTab = ImageAsset(name: "profile_tab")
    internal static let rick = ImageAsset(name: "rick")
    internal static let rizza = ImageAsset(name: "rizza")
    internal static let room = ImageAsset(name: "room")
    internal static let search = ImageAsset(name: "search")
    internal static let sort = ImageAsset(name: "sort")
    internal static let star = ImageAsset(name: "star")
    internal static let userEdit = ImageAsset(name: "user-edit")
    internal static let user = ImageAsset(name: "user")
    internal static let wallet = ImageAsset(name: "wallet")
  }
  internal enum Colors {
    internal static let sBackground = ColorAsset(name: "sBackground")
    internal static let sBlack = ColorAsset(name: "sBlack")
    internal static let sGray = ColorAsset(name: "sGray")
    internal static let sGreen = ColorAsset(name: "sGreen")
    internal static let sGreenBack = ColorAsset(name: "sGreenBack")
    internal static let sGreenBoarder = ColorAsset(name: "sGreenBoarder")
    internal static let sGreenBoarderStrong = ColorAsset(name: "sGreenBoarderStrong")
    internal static let sRed = ColorAsset(name: "sRed")
    internal static let sSecondary = ColorAsset(name: "sSecondary")
    internal static let sWhiteBlue = ColorAsset(name: "sWhiteBlue")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
