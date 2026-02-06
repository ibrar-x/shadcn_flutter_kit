part of '../../switch.dart';

/// Controlled switch with a controller or initial value.
class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  @override
  final bool initialValue;
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool enabled;
  @override
  final SwitchController? controller;

  final Widget? leading;
  final Widget? trailing;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final BorderRadiusGeometry? borderRadius;

  const ControlledSwitch({
    super.key,
    this.controller,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Switch(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          leading: leading,
          trailing: trailing,
          gap: gap,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          activeThumbColor: activeThumbColor,
          inactiveThumbColor: inactiveThumbColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}
