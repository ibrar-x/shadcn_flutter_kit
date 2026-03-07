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
import 'display/markdown/_impl/themes/config/markdown_theme_config.dart' as c16;
import 'display/number_ticker/_impl/themes/config/number_ticker_theme_config.dart' as c17;
import 'display/progress/_impl/themes/config/progress_theme_config.dart' as c18;
import 'display/skeleton/_impl/themes/config/skeleton_theme_config.dart' as c19;
import 'display/spinner/_impl/themes/config/spinner_theme_config.dart' as c20;
import 'display/text_animate/_impl/themes/config/text_animate_theme_config.dart' as c21;
import 'display/tracker/_impl/themes/config/tracker_theme_config.dart' as c22;
import 'form/checkbox/_impl/themes/config/checkbox_theme_config.dart' as c23;
import 'form/chip_input/_impl/themes/config/chip_input_theme_config.dart' as c24;
import 'form/color_input/_impl/themes/config/color_input_theme_config.dart' as c25;
import 'form/color_picker/_impl/themes/config/color_picker_theme_config.dart' as c26;
import 'form/date_picker/_impl/themes/config/date_picker_theme_config.dart' as c27;
import 'form/file_picker/_impl/themes/config/file_picker_theme_config.dart' as c28;
import 'form/formatted_input/_impl/themes/config/formatted_input_theme_config.dart' as c29;
import 'form/input_otp/_impl/themes/config/input_otp_theme_config.dart' as c30;
import 'form/multiple_choice/_impl/themes/config/multiple_choice_theme_config.dart' as c31;
import 'form/phone_input/_impl/themes/config/phone_input_theme_config.dart' as c32;
import 'form/radio_group/_impl/themes/config/radio_group_theme_config.dart' as c33;
import 'form/select/_impl/themes/config/select_theme_config.dart' as c34;
import 'form/slider/_impl/themes/config/slider_theme_config.dart' as c35;
import 'form/star_rating/_impl/themes/config/star_rating_theme_config.dart' as c36;
import 'form/switch/_impl/themes/config/switch_theme_config.dart' as c37;
import 'form/text_field/_impl/themes/config/text_field_theme_config.dart' as c38;
import 'form/time_picker/_impl/themes/config/time_picker_theme_config.dart' as c39;
import 'layout/accordion/_impl/themes/config/accordion_theme_config.dart' as c40;
import 'layout/alert/_impl/themes/config/alert_theme_config.dart' as c41;
import 'layout/card/_impl/themes/config/card_theme_config.dart' as c42;
import 'layout/collapsible/_impl/themes/config/collapsible_theme_config.dart' as c43;
import 'layout/filter_bar/_impl/themes/config/filter_bar_theme_config.dart' as c44;
import 'layout/hidden/_impl/themes/config/hidden_theme_config.dart' as c45;
import 'layout/outlined_container/_impl/themes/config/outlined_container_theme_config.dart' as c46;
import 'layout/scrollable/_impl/themes/config/scrollable_theme_config.dart' as c47;
import 'layout/stage_container/_impl/themes/config/stage_container_theme_config.dart' as c48;
import 'layout/table/_impl/themes/config/table_theme_config.dart' as c49;
import 'navigation/navigation_bar/_impl/themes/config/navigation_bar_theme_config.dart' as c50;
import 'navigation/stepper/_impl/themes/config/stepper_theme_config.dart' as c51;
import 'navigation/tabs/_impl/themes/config/tabs_theme_config.dart' as c52;
import 'overlay/context_menu/_impl/themes/config/context_menu_theme_config.dart' as c53;
import 'overlay/dialog/_impl/themes/config/dialog_theme_config.dart' as c54;
import 'overlay/drawer/_impl/themes/config/drawer_theme_config.dart' as c55;
import 'overlay/dropdown_menu/_impl/themes/config/dropdown_menu_theme_config.dart' as c56;
import 'overlay/gooey_toast/_impl/themes/config/gooey_toast_theme_config.dart' as c57;
import 'overlay/hover_card/_impl/themes/config/hover_card_theme_config.dart' as c58;
import 'overlay/menu/_impl/themes/config/menu_theme_config.dart' as c59;
import 'overlay/menubar/_impl/themes/config/menubar_theme_config.dart' as c60;
import 'overlay/popup/_impl/themes/config/popup_theme_config.dart' as c61;
import 'overlay/refresh_trigger/_impl/themes/config/refresh_trigger_theme_config.dart' as c62;
import 'overlay/swiper/_impl/themes/config/swiper_theme_config.dart' as c63;
import 'overlay/toast/_impl/themes/config/toast_theme_config.dart' as c64;
import 'overlay/tooltip/_impl/themes/config/tooltip_theme_config.dart' as c65;
import 'utility/error_system/_impl/themes/config/error_system_theme_config.dart' as c66;
import 'utility/focus_outline/_impl/themes/config/focus_outline_theme_config.dart' as c67;

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
    c16.MarkdownThemeConfig.globalType,
    () => c16.MarkdownThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c17.NumberTickerThemeConfig.globalType,
    () => c17.NumberTickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c18.ProgressThemeConfig.globalType,
    () => c18.ProgressThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c19.SkeletonThemeConfig.globalType,
    () => c19.SkeletonThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c20.SpinnerThemeConfig.globalType,
    () => c20.SpinnerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c21.TextAnimateThemeConfig.globalType,
    () => c21.TextAnimateThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c22.TrackerThemeConfig.globalType,
    () => c22.TrackerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c23.CheckboxThemeConfig.globalType,
    () => c23.CheckboxThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c24.ChipInputThemeConfig.globalType,
    () => c24.ChipInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c25.ColorInputThemeConfig.globalType,
    () => c25.ColorInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c26.ColorPickerThemeConfig.globalType,
    () => c26.ColorPickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c27.DatePickerThemeConfig.globalType,
    () => c27.DatePickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c28.FilePickerThemeConfig.fileUploadDropzoneThemeType,
    () => c28.FilePickerThemeConfig.fileUploadDropzoneTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c29.FormattedInputThemeConfig.globalType,
    () => c29.FormattedInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c30.InputOtpThemeConfig.inputOTPThemeType,
    () => c30.InputOtpThemeConfig.inputOTPTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c31.MultipleChoiceThemeConfig.globalType,
    () => c31.MultipleChoiceThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c32.PhoneInputThemeConfig.globalType,
    () => c32.PhoneInputThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c33.RadioGroupThemeConfig.radioCardThemeType,
    () => c33.RadioGroupThemeConfig.radioCardTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c33.RadioGroupThemeConfig.radioThemeType,
    () => c33.RadioGroupThemeConfig.radioTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c34.SelectThemeConfig.globalType,
    () => c34.SelectThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c35.SliderThemeConfig.globalType,
    () => c35.SliderThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c36.StarRatingThemeConfig.globalType,
    () => c36.StarRatingThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c37.SwitchThemeConfig.globalType,
    () => c37.SwitchThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c38.TextFieldThemeConfig.globalType,
    () => c38.TextFieldThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c39.TimePickerThemeConfig.globalType,
    () => c39.TimePickerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c40.AccordionThemeConfig.globalType,
    () => c40.AccordionThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c41.AlertThemeConfig.globalType,
    () => c41.AlertThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c42.CardThemeConfig.globalType,
    () => c42.CardThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c43.CollapsibleThemeConfig.globalType,
    () => c43.CollapsibleThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c44.FilterBarThemeConfig.globalType,
    () => c44.FilterBarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c45.HiddenThemeConfig.globalType,
    () => c45.HiddenThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c46.OutlinedContainerThemeConfig.globalType,
    () => c46.OutlinedContainerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c47.ScrollableThemeConfig.scrollableClientThemeType,
    () => c47.ScrollableThemeConfig.scrollableClientTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c48.StageContainerThemeConfig.globalType,
    () => c48.StageContainerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c49.TableThemeConfig.globalType,
    () => c49.TableThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c49.TableThemeConfig.resizableTableThemeType,
    () => c49.TableThemeConfig.resizableTableTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c50.NavigationBarThemeConfig.globalType,
    () => c50.NavigationBarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c51.StepperThemeConfig.globalType,
    () => c51.StepperThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c52.TabsThemeConfig.globalType,
    () => c52.TabsThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c52.TabsThemeConfig.tabContainerThemeType,
    () => c52.TabsThemeConfig.tabContainerTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c52.TabsThemeConfig.tabListThemeType,
    () => c52.TabsThemeConfig.tabListTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c52.TabsThemeConfig.tabPaneThemeType,
    () => c52.TabsThemeConfig.tabPaneTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c53.ContextMenuThemeConfig.globalType,
    () => c53.ContextMenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c54.DialogThemeConfig.modalBackdropThemeType,
    () => c54.DialogThemeConfig.modalBackdropTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c55.DrawerThemeConfig.globalType,
    () => c55.DrawerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c56.DropdownMenuThemeConfig.globalType,
    () => c56.DropdownMenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c57.GooeyToastThemeConfig.globalType,
    () => c57.GooeyToastThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c58.HoverCardThemeConfig.globalType,
    () => c58.HoverCardThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c59.MenuThemeConfig.globalType,
    () => c59.MenuThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c59.MenuThemeConfig.menuPopupThemeType,
    () => c59.MenuThemeConfig.menuPopupTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c59.MenuThemeConfig.menubarThemeType,
    () => c59.MenuThemeConfig.menubarTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c60.MenubarThemeConfig.globalType,
    () => c60.MenubarThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c61.PopupThemeConfig.menuPopupThemeType,
    () => c61.PopupThemeConfig.menuPopupTheme,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c62.RefreshTriggerThemeConfig.globalType,
    () => c62.RefreshTriggerThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c63.SwiperThemeConfig.globalType,
    () => c63.SwiperThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c64.ToastThemeConfig.globalType,
    () => c64.ToastThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c65.TooltipThemeConfig.globalType,
    () => c65.TooltipThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c66.ErrorSystemThemeConfig.globalType,
    () => c66.ErrorSystemThemeConfig.global,
  );
  ComponentThemeGlobalRegistry.registerByName(
    c67.FocusOutlineThemeConfig.globalType,
    () => c67.FocusOutlineThemeConfig.global,
  );
  _componentThemeGlobalsRegistered = true;
}
