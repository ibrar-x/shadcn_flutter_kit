import 'package:flutter/foundation.dart';

import 'feature_carousel_models.dart';

enum FeatureCarouselAnimationStyle {
  crossfadeScale,
  slideFade,
  blurFade,
  rotateParallax,
  liftFade,
  slideUpFade,
  slideDownFade,
  rotateFade,
  zoomFade,
}

class FeatureCarouselController extends ChangeNotifier {
  FeatureCarouselController({
    int initialIndex = 0,
    this.showCta = true,
    this.showNavArrows = true,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.animationStyle = FeatureCarouselAnimationStyle.slideFade,
    this.cycleAnimationStyles = true,
    this.enableKeyboardNavigation = true,
    this.enableSwipe = true,
    this.primaryActionLabel = 'Add to chat',
    this.onPrimaryAction,
    this.onIndexChanged,
  }) : _index = initialIndex;

  int _index;
  bool showCta;
  bool showNavArrows;
  bool autoPlay;
  Duration autoPlayInterval;
  FeatureCarouselAnimationStyle animationStyle;
  bool cycleAnimationStyles;
  bool enableKeyboardNavigation;
  bool enableSwipe;
  String primaryActionLabel;
  void Function(FeatureCarouselItem item, int index)? onPrimaryAction;
  void Function(int index)? onIndexChanged;

  int get index => _index;

  set index(int value) {
    if (_index == value) return;
    _index = value;
    notifyListeners();
    onIndexChanged?.call(_index);
  }

  void next(int itemCount) {
    if (itemCount == 0) return;
    index = (index + 1) % itemCount;
  }

  void previous(int itemCount) {
    if (itemCount == 0) return;
    index = (index - 1 + itemCount) % itemCount;
  }

  void update({
    bool? showCta,
    bool? showNavArrows,
    bool? autoPlay,
    Duration? autoPlayInterval,
    FeatureCarouselAnimationStyle? animationStyle,
    bool? cycleAnimationStyles,
    bool? enableKeyboardNavigation,
    bool? enableSwipe,
    String? primaryActionLabel,
    void Function(FeatureCarouselItem item, int index)? onPrimaryAction,
    void Function(int index)? onIndexChanged,
  }) {
    var dirty = false;
    if (showCta != null && showCta != this.showCta) {
      this.showCta = showCta;
      dirty = true;
    }
    if (showNavArrows != null && showNavArrows != this.showNavArrows) {
      this.showNavArrows = showNavArrows;
      dirty = true;
    }
    if (autoPlay != null && autoPlay != this.autoPlay) {
      this.autoPlay = autoPlay;
      dirty = true;
    }
    if (autoPlayInterval != null && autoPlayInterval != this.autoPlayInterval) {
      this.autoPlayInterval = autoPlayInterval;
      dirty = true;
    }
    if (animationStyle != null && animationStyle != this.animationStyle) {
      this.animationStyle = animationStyle;
      dirty = true;
    }
    if (cycleAnimationStyles != null &&
        cycleAnimationStyles != this.cycleAnimationStyles) {
      this.cycleAnimationStyles = cycleAnimationStyles;
      dirty = true;
    }
    if (enableKeyboardNavigation != null &&
        enableKeyboardNavigation != this.enableKeyboardNavigation) {
      this.enableKeyboardNavigation = enableKeyboardNavigation;
      dirty = true;
    }
    if (enableSwipe != null && enableSwipe != this.enableSwipe) {
      this.enableSwipe = enableSwipe;
      dirty = true;
    }
    if (primaryActionLabel != null &&
        primaryActionLabel != this.primaryActionLabel) {
      this.primaryActionLabel = primaryActionLabel;
      dirty = true;
    }
    if (onPrimaryAction != null) {
      this.onPrimaryAction = onPrimaryAction;
      dirty = true;
    }
    if (onIndexChanged != null) {
      this.onIndexChanged = onIndexChanged;
      dirty = true;
    }
    if (dirty) {
      notifyListeners();
    }
  }
}
