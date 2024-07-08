import 'package:flutter/material.dart';

class TmdbImageNetworkWidget extends StatelessWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool excludeFromSemantics;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final bool isAntiAlias;
  final Rect? centerSlice;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;

  const TmdbImageNetworkWidget(
    this.src, {
    super.key,
    this.height = 150.0,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.excludeFromSemantics = false,
    this.cacheWidth,
    this.cacheHeight,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.isAntiAlias = false,
    this.centerSlice,
    this.loadingBuilder,
  });

  @visibleForTesting
  static const baseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Image.network('$baseUrl$src',
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        excludeFromSemantics: excludeFromSemantics,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        color: color,
        colorBlendMode: colorBlendMode,
        filterQuality: filterQuality,
        isAntiAlias: isAntiAlias,
        centerSlice: centerSlice,
        loadingBuilder: loadingBuilder ??
            (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const CircularProgressIndicator();
            });
  }
}
