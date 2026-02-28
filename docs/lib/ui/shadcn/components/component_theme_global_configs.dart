// GENERATED CODE - DO NOT MODIFY BY HAND.
// Run: dart run tool/theme/component_theme_global_configs_generate.dart

import '../shared/theme/component_theme_global_registry.dart';
import 'control/button/_impl/themes/config/button_theme_config.dart' as c0;
import 'control/hover/_impl/themes/config/hover_theme_config.dart' as c1;
import 'control/scrollbar/_impl/themes/config/scrollbar_theme_config.dart' as c2;
import 'display/avatar/_impl/themes/config/avatar_theme_config.dart' as c3;
import 'display/badge/_impl/themes/config/badge_theme_config.dart' as c4;
import 'display/calendar/_impl/themes/config/calendar_theme_config.dart' as c5;
import 'display/carousel/_impl/themes/config/carousel_theme_config.dart' as c6;
import 'display/chip/_impl/themes/config/chip_theme_config.dart' as c7;
import 'display/circular_progress_indicator/_impl/themes/config/circular_progress_indicator_theme_config.dart' as c8;
import 'display/code_snippet/_impl/themes/config/code_snippet_theme_config.dart' as c9;
import 'display/divider/_impl/themes/config/divider_theme_config.dart' as c10;
import 'display/dot_indicator/_impl/themes/config/dot_indicator_theme_config.dart' as c11;
import 'display/empty_state/_impl/themes/config/empty_state_theme_config.dart' as c12;
import 'display/feature_carousel/_impl/themes/config/feature_carousel_theme_config.dart' as c13;
import 'display/keyboard_shortcut/_impl/themes/config/keyboard_shortcut_theme_config.dart' as c14;
import 'display/linear_progress_indicator/_impl/themes/config/linear_progress_indicator_theme_config.dart' as c15;
import 'display/number_ticker/_impl/themes/config/number_ticker_theme_config.dart' as c16;
import 'display/progress/_impl/themes/config/progress_theme_config.dart' as c17;
import 'display/skeleton/_impl/themes/config/skeleton_theme_config.dart' as c18;
import 'display/spinner/_impl/themes/config/spinner_theme_config.dart' as c19;
import 'display/text_animate/_impl/themes/config/text_animate_theme_config.dart' as c20;
import 'display/tracker/_impl/themes/config/tracker_theme_config.dart' as c21;
import 'form/checkbox/_impl/themes/config/checkbox_theme_config.dart' as c22;
import 'form/chip_input/_impl/themes/config/chip_input_theme_config.dart' as c23;
import 'form/color_input/_impl/themes/config/color_input_theme_config.dart' as c24;
import 'form/color_picker/_impl/themes/config/color_picker_theme_config.dart' as c25;
import 'form/date_picker/_impl/themes/config/date_picker_theme_config.dart' as c26;
import 'form/file_picker/_impl/themes/config/file_picker_theme_config.dart' as c27;
import 'form/formatted_input/_impl/themes/config/formatted_input_theme_config.dart' as c28;
import 'form/input_otp/_impl/themes/config/input_otp_theme_config.dart' as c29;
import 'form/multiple_choice/_impl/themes/config/multiple_choice_theme_config.dart' as c30;
import 'form/phone_input/_impl/themes/config/phone_input_theme_config.dart' as c31;
import 'form/radio_group/_impl/themes/config/radio_group_theme_config.dart' as c32;
import 'form/select/_impl/themes/config/select_theme_config.dart' as c33;
import 'form/slider/_impl/themes/config/slider_theme_config.dart' as c34;
import 'form/star_rating/_impl/themes/config/star_rating_theme_config.dart' as c35;
import 'form/switch/_impl/themes/config/switch_theme_config.dart' as c36;
import 'form/text_field/_impl/themes/config/text_field_theme_config.dart' as c37;
import 'form/time_picker/_impl/themes/config/time_picker_theme_config.dart' as c38;
import 'layout/accordion/_impl/themes/config/accordion_theme_config.dart' as c39;
import 'layout/alert/_impl/themes/config/alert_theme_config.dart' as c40;
import 'layout/card/_impl/themes/config/card_theme_config.dart' as c41;
import 'layout/collapsible/_impl/themes/config/collapsible_theme_config.dart' as c42;
import 'layout/filter_bar/_impl/themes/config/filter_bar_theme_config.dart' as c43;
import 'layout/hidden/_impl/themes/config/hidden_theme_config.dart' as c44;
import 'layout/outlined_container/_impl/themes/config/outlined_container_theme_config.dart' as c45;
import 'layout/scrollable/_impl/themes/config/scrollable_theme_config.dart' as c46;
import 'layout/stage_container/_impl/themes/config/stage_container_theme_config.dart' as c47;
import 'layout/table/_impl/themes/config/table_theme_config.dart' as c48;
import 'navigation/navigation_bar/_impl/themes/config/navigation_bar_theme_config.dart' as c49;
import 'navigation/stepper/_impl/themes/config/stepper_theme_config.dart' as c50;
import 'navigation/tabs/_impl/themes/config/tabs_theme_config.dart' as c51;
import 'overlay/context_menu/_impl/themes/config/context_menu_theme_config.dart' as c52;
import 'overlay/dialog/_impl/themes/config/dialog_theme_config.dart' as c53;
import 'overlay/drawer/_impl/themes/config/drawer_theme_config.dart' as c54;
import 'overlay/dropdown_menu/_impl/themes/config/dropdown_menu_theme_config.dart' as c55;
import 'overlay/gooey_toast/_impl/themes/config/gooey_toast_theme_config.dart' as c56;
import 'overlay/hover_card/_impl/themes/config/hover_card_theme_config.dart' as c57;
import 'overlay/menu/_impl/themes/config/menu_theme_config.dart' as c58;
import 'overlay/menubar/_impl/themes/config/menubar_theme_config.dart' as c59;
import 'overlay/popup/_impl/themes/config/popup_theme_config.dart' as c60;
import 'overlay/refresh_trigger/_impl/themes/config/refresh_trigger_theme_config.dart' as c61;
import 'overlay/swiper/_impl/themes/config/swiper_theme_config.dart' as c62;
import 'overlay/toast/_impl/themes/config/toast_theme_config.dart' as c63;
import 'overlay/tooltip/_impl/themes/config/tooltip_theme_config.dart' as c64;
import 'utility/error_system/_impl/themes/config/error_system_theme_config.dart' as c65;
import 'utility/focus_outline/_impl/themes/config/focus_outline_theme_config.dart' as c66;

bool _componentThemeGlobalsRegistered = false;

/// Registers all component token-config globals once.
void registerComponentThemeGlobalConfigs() {
  if (_componentThemeGlobalsRegistered) return;
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.primaryButtonThemeType,
    () => c0.ButtonThemeConfig.primaryButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.secondaryButtonThemeType,
    () => c0.ButtonThemeConfig.secondaryButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.outlineButtonThemeType,
    () => c0.ButtonThemeConfig.outlineButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.ghostButtonThemeType,
    () => c0.ButtonThemeConfig.ghostButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.linkButtonThemeType,
    () => c0.ButtonThemeConfig.linkButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.textButtonThemeType,
    () => c0.ButtonThemeConfig.textButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.destructiveButtonThemeType,
    () => c0.ButtonThemeConfig.destructiveButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.fixedButtonThemeType,
    () => c0.ButtonThemeConfig.fixedButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.menuButtonThemeType,
    () => c0.ButtonThemeConfig.menuButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.menubarButtonThemeType,
    () => c0.ButtonThemeConfig.menubarButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.mutedButtonThemeType,
    () => c0.ButtonThemeConfig.mutedButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c0.ButtonThemeConfig.cardButtonThemeType,
    () => c0.ButtonThemeConfig.cardButtonTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c1.HoverThemeConfig.globalType,
    () => c1.HoverThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c2.ScrollbarThemeConfig.globalType,
    () => c2.ScrollbarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c3.AvatarThemeConfig.globalType,
    () => c3.AvatarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c4.BadgeThemeConfig.globalType,
    () => c4.BadgeThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c5.CalendarThemeConfig.globalType,
    () => c5.CalendarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c6.CarouselThemeConfig.globalType,
    () => c6.CarouselThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c7.ChipThemeConfig.globalType,
    () => c7.ChipThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c8.CircularProgressIndicatorThemeConfig.globalType,
    () => c8.CircularProgressIndicatorThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c9.CodeSnippetThemeConfig.globalType,
    () => c9.CodeSnippetThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c10.DividerThemeConfig.globalType,
    () => c10.DividerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c11.DotIndicatorThemeConfig.globalType,
    () => c11.DotIndicatorThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c12.EmptyStateThemeConfig.globalType,
    () => c12.EmptyStateThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c13.FeatureCarouselThemeConfig.globalType,
    () => c13.FeatureCarouselThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c14.KeyboardShortcutThemeConfig.globalType,
    () => c14.KeyboardShortcutThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c15.LinearProgressIndicatorThemeConfig.globalType,
    () => c15.LinearProgressIndicatorThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c16.NumberTickerThemeConfig.globalType,
    () => c16.NumberTickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c17.ProgressThemeConfig.globalType,
    () => c17.ProgressThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c18.SkeletonThemeConfig.globalType,
    () => c18.SkeletonThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c19.SpinnerThemeConfig.globalType,
    () => c19.SpinnerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c20.TextAnimateThemeConfig.globalType,
    () => c20.TextAnimateThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c21.TrackerThemeConfig.globalType,
    () => c21.TrackerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c22.CheckboxThemeConfig.globalType,
    () => c22.CheckboxThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c23.ChipInputThemeConfig.globalType,
    () => c23.ChipInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c24.ColorInputThemeConfig.globalType,
    () => c24.ColorInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c25.ColorPickerThemeConfig.globalType,
    () => c25.ColorPickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c26.DatePickerThemeConfig.globalType,
    () => c26.DatePickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c27.FilePickerThemeConfig.fileUploadDropzoneThemeType,
    () => c27.FilePickerThemeConfig.fileUploadDropzoneTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c28.FormattedInputThemeConfig.globalType,
    () => c28.FormattedInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c29.InputOtpThemeConfig.inputOTPThemeType,
    () => c29.InputOtpThemeConfig.inputOTPTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c30.MultipleChoiceThemeConfig.globalType,
    () => c30.MultipleChoiceThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c31.PhoneInputThemeConfig.globalType,
    () => c31.PhoneInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c32.RadioGroupThemeConfig.radioCardThemeType,
    () => c32.RadioGroupThemeConfig.radioCardTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c32.RadioGroupThemeConfig.radioThemeType,
    () => c32.RadioGroupThemeConfig.radioTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c33.SelectThemeConfig.globalType,
    () => c33.SelectThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c34.SliderThemeConfig.globalType,
    () => c34.SliderThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c35.StarRatingThemeConfig.globalType,
    () => c35.StarRatingThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c36.SwitchThemeConfig.globalType,
    () => c36.SwitchThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c37.TextFieldThemeConfig.globalType,
    () => c37.TextFieldThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c38.TimePickerThemeConfig.globalType,
    () => c38.TimePickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c39.AccordionThemeConfig.globalType,
    () => c39.AccordionThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c40.AlertThemeConfig.globalType,
    () => c40.AlertThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c41.CardThemeConfig.globalType,
    () => c41.CardThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c42.CollapsibleThemeConfig.globalType,
    () => c42.CollapsibleThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c43.FilterBarThemeConfig.globalType,
    () => c43.FilterBarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c44.HiddenThemeConfig.globalType,
    () => c44.HiddenThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c45.OutlinedContainerThemeConfig.globalType,
    () => c45.OutlinedContainerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c46.ScrollableThemeConfig.scrollableClientThemeType,
    () => c46.ScrollableThemeConfig.scrollableClientTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c47.StageContainerThemeConfig.globalType,
    () => c47.StageContainerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c48.TableThemeConfig.globalType,
    () => c48.TableThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c48.TableThemeConfig.resizableTableThemeType,
    () => c48.TableThemeConfig.resizableTableTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c49.NavigationBarThemeConfig.globalType,
    () => c49.NavigationBarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c50.StepperThemeConfig.globalType,
    () => c50.StepperThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c51.TabsThemeConfig.globalType,
    () => c51.TabsThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c51.TabsThemeConfig.tabContainerThemeType,
    () => c51.TabsThemeConfig.tabContainerTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c51.TabsThemeConfig.tabListThemeType,
    () => c51.TabsThemeConfig.tabListTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c51.TabsThemeConfig.tabPaneThemeType,
    () => c51.TabsThemeConfig.tabPaneTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c52.ContextMenuThemeConfig.globalType,
    () => c52.ContextMenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c53.DialogThemeConfig.modalBackdropThemeType,
    () => c53.DialogThemeConfig.modalBackdropTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c54.DrawerThemeConfig.globalType,
    () => c54.DrawerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c55.DropdownMenuThemeConfig.globalType,
    () => c55.DropdownMenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c56.GooeyToastThemeConfig.globalType,
    () => c56.GooeyToastThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c57.HoverCardThemeConfig.globalType,
    () => c57.HoverCardThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c58.MenuThemeConfig.globalType,
    () => c58.MenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c58.MenuThemeConfig.menuPopupThemeType,
    () => c58.MenuThemeConfig.menuPopupTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c58.MenuThemeConfig.menubarThemeType,
    () => c58.MenuThemeConfig.menubarTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c59.MenubarThemeConfig.globalType,
    () => c59.MenubarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c60.PopupThemeConfig.menuPopupThemeType,
    () => c60.PopupThemeConfig.menuPopupTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c61.RefreshTriggerThemeConfig.globalType,
    () => c61.RefreshTriggerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c62.SwiperThemeConfig.globalType,
    () => c62.SwiperThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c63.ToastThemeConfig.globalType,
    () => c63.ToastThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c64.TooltipThemeConfig.globalType,
    () => c64.TooltipThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c65.ErrorSystemThemeConfig.globalType,
    () => c65.ErrorSystemThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c66.FocusOutlineThemeConfig.globalType,
    () => c66.FocusOutlineThemeConfig.global,
  );
  _componentThemeGlobalsRegistered = true;
}
