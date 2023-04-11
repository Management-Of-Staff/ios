import ProjectDescription

let config = Config(

)

//extension SettingsDictionary {
//  func setProductBundleIdentifier(_ value: String = "com.iOS$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
//    merging(["PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: value)])
//  }
//  func setAssetcatalogCompilerAppIconName(_ value: String = "AppIcon$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
//    merging(["ASSETCATALOG_COMPILER_APPICON_NAME": SettingValue(stringLiteral: value)])
//  }
//  func setBuildActiveArchitectureOnly(_ value: Bool) -> SettingsDictionary {
//    merging(["ONLY_ACTIVE_ARCH": SettingValue(stringLiteral: value ? "YES" : "NO")])
//  }
//  func setExcludedArchitectures(sdk: String = "iphonesimulator*", _ value: String = "arm64") -> SettingsDictionary {
//    merging(["EXCLUDED_ARCHS[sdk=\(sdk)]": SettingValue(stringLiteral: value)])
//  }
//  func setSwiftActiveComplationConditions(_ value: String) -> SettingsDictionary {
//    merging(["SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: value)])
//  }
//  func setAlwaysSearchUserPath(_ value: String = "NO") -> SettingsDictionary {
//    merging(["ALWAYS_SEARCH_USER_PATHS": SettingValue(stringLiteral: value)])
//  }
//  func setStripDebugSymbolsDuringCopy(_ value: String = "NO") -> SettingsDictionary {
//    merging(["COPY_PHASE_STRIP": SettingValue(stringLiteral: value)])
//  }
//  func setDynamicLibraryInstallNameBase(_ value: String = "@rpath") -> SettingsDictionary {
//    merging(["DYLIB_INSTALL_NAME_BASE": SettingValue(stringLiteral: value)])
//  }
//  func setSkipInstall(_ value: Bool = false) -> SettingsDictionary {
//    merging(["SKIP_INSTALL": SettingValue(stringLiteral: value ? "YES" : "NO")])
//  }
//}
