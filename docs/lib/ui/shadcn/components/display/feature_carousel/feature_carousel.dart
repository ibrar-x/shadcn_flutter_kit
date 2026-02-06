import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_impl/state/feature_carousel_controller.dart';
import '_impl/utils/feature_carousel_animation_style.dart';
import '_impl/utils/feature_carousel_models.dart';
import '_impl/themes/feature_carousel_theme.dart';
import '../../../shared/theme/theme.dart' as shadcn_theme;

export '_impl/utils/feature_carousel_models.dart';
export '_impl/utils/feature_carousel_animation_style.dart';
export '_impl/state/feature_carousel_controller.dart';
export '_impl/themes/feature_carousel_theme.dart';

part '_impl/core/_carousel_intent.dart';
part '_impl/core/_center_card.dart';
part '_impl/core/_cta_button.dart';
part '_impl/core/_feature_card_carousel_state.dart';
part '_impl/core/_ghost_card.dart';
part '_impl/core/_ghost_transform.dart';
part '_impl/core/_nav_arrow.dart';
part '_impl/core/feature_card_carousel.dart';

enum _CarouselDirection { left, right }
