/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow_left_linear.svg
  SvgGenImage get arrowLeftLinear =>
      const SvgGenImage('assets/icons/arrow_left_linear.svg');

  /// File path: assets/icons/arrow_right_linear.svg
  SvgGenImage get arrowRightLinear =>
      const SvgGenImage('assets/icons/arrow_right_linear.svg');

  /// File path: assets/icons/category_outline.svg
  SvgGenImage get categoryOutline =>
      const SvgGenImage('assets/icons/category_outline.svg');

  /// File path: assets/icons/category_sharp.svg
  SvgGenImage get categorySharp =>
      const SvgGenImage('assets/icons/category_sharp.svg');

  /// File path: assets/icons/filter_bold.svg
  SvgGenImage get filterBold =>
      const SvgGenImage('assets/icons/filter_bold.svg');

  /// File path: assets/icons/image_broken.svg
  SvgGenImage get imageBroken =>
      const SvgGenImage('assets/icons/image_broken.svg');

  /// File path: assets/icons/info-circle-bold.svg
  SvgGenImage get infoCircleBold =>
      const SvgGenImage('assets/icons/info-circle-bold.svg');

  /// File path: assets/icons/magnifer_linear.svg
  SvgGenImage get magniferLinear =>
      const SvgGenImage('assets/icons/magnifer_linear.svg');

  /// File path: assets/icons/moon-bold.svg
  SvgGenImage get moonBold => const SvgGenImage('assets/icons/moon-bold.svg');

  /// File path: assets/icons/phone-rounded-bold.svg
  SvgGenImage get phoneRoundedBold =>
      const SvgGenImage('assets/icons/phone-rounded-bold.svg');

  /// File path: assets/icons/question-circle-bold.svg
  SvgGenImage get questionCircleBold =>
      const SvgGenImage('assets/icons/question-circle-bold.svg');

  /// File path: assets/icons/reel_linear.svg
  SvgGenImage get reelLinear =>
      const SvgGenImage('assets/icons/reel_linear.svg');

  /// File path: assets/icons/restart_linear.svg
  SvgGenImage get restartLinear =>
      const SvgGenImage('assets/icons/restart_linear.svg');

  /// File path: assets/icons/rounded_magnifer_outline.svg
  SvgGenImage get roundedMagniferOutline =>
      const SvgGenImage('assets/icons/rounded_magnifer_outline.svg');

  /// File path: assets/icons/rounded_magnifer_sharp.svg
  SvgGenImage get roundedMagniferSharp =>
      const SvgGenImage('assets/icons/rounded_magnifer_sharp.svg');

  /// File path: assets/icons/sun-bold.svg
  SvgGenImage get sunBold => const SvgGenImage('assets/icons/sun-bold.svg');

  /// File path: assets/icons/user_outline.svg
  SvgGenImage get userOutline =>
      const SvgGenImage('assets/icons/user_outline.svg');

  /// File path: assets/icons/user_rounded_outline.svg
  SvgGenImage get userRoundedOutline =>
      const SvgGenImage('assets/icons/user_rounded_outline.svg');

  /// File path: assets/icons/user_sharp.svg
  SvgGenImage get userSharp => const SvgGenImage('assets/icons/user_sharp.svg');

  /// File path: assets/icons/video_frame_outline.svg
  SvgGenImage get videoFrameOutline =>
      const SvgGenImage('assets/icons/video_frame_outline.svg');

  /// File path: assets/icons/video_frame_sharp.svg
  SvgGenImage get videoFrameSharp =>
      const SvgGenImage('assets/icons/video_frame_sharp.svg');

  /// File path: assets/icons/wifi_low_bound.svg
  SvgGenImage get wifiLowBound =>
      const SvgGenImage('assets/icons/wifi_low_bound.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        arrowLeftLinear,
        arrowRightLinear,
        categoryOutline,
        categorySharp,
        filterBold,
        imageBroken,
        infoCircleBold,
        magniferLinear,
        moonBold,
        phoneRoundedBold,
        questionCircleBold,
        reelLinear,
        restartLinear,
        roundedMagniferOutline,
        roundedMagniferSharp,
        sunBold,
        userOutline,
        userRoundedOutline,
        userSharp,
        videoFrameOutline,
        videoFrameSharp,
        wifiLowBound
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/error_emote.svg
  SvgGenImage get errorEmote =>
      const SvgGenImage('assets/images/error_emote.svg');

  /// File path: assets/images/login_tv.png
  AssetGenImage get loginTv =>
      const AssetGenImage('assets/images/login_tv.png');

  /// File path: assets/images/test.png
  AssetGenImage get test => const AssetGenImage('assets/images/test.png');

  /// File path: assets/images/walking_dead.jpg
  AssetGenImage get walkingDead =>
      const AssetGenImage('assets/images/walking_dead.jpg');

  /// List of all assets
  List<dynamic> get values => [errorEmote, loginTv, test, walkingDead];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
