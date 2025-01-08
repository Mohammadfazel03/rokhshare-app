import 'package:flutter/material.dart';

class InteractiveCheckboxListTile extends StatefulWidget {
  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final MouseCursor? mouseCursor;

  final Color? activeColor;

  final WidgetStatePropertyAll<Color?>? fillColor;

  final Color? checkColor;

  final Color? hoverColor;

  final WidgetStatePropertyAll<Color?>? overlayColor;

  final double? splashRadius;

  final MaterialTapTargetSize? materialTapTargetSize;

  final VisualDensity? visualDensity;

  final FocusNode? focusNode;

  final bool autofocus;

  final ShapeBorder? shape;

  final BorderSide? side;

  final bool isError;

  final Color? tileColor;

  final Widget? title;

  final Widget? subtitle;

  final Widget? secondary;

  final bool isThreeLine;

  final bool? dense;

  final bool selected;

  final ListTileControlAffinity controlAffinity;

  final EdgeInsetsGeometry? contentPadding;

  final bool tristate;

  final OutlinedBorder? checkboxShape;

  final Color? selectedTileColor;

  final ValueChanged<bool>? onFocusChange;

  final bool? enableFeedback;

  final bool? enabled;

  final String? checkboxSemanticLabel;

  const InteractiveCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.enabled,
    this.tileColor,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.contentPadding,
    this.tristate = false,
    this.checkboxShape,
    this.selectedTileColor,
    this.onFocusChange,
    this.enableFeedback,
    this.checkboxSemanticLabel,
  });

  @override
  State<InteractiveCheckboxListTile> createState() =>
      _InteractiveCheckboxListTileState();
}

class _InteractiveCheckboxListTileState
    extends State<InteractiveCheckboxListTile> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: _value,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _value = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }
        },
        mouseCursor: widget.mouseCursor,
        activeColor: widget.activeColor,
        fillColor: widget.fillColor,
        checkColor: widget.checkColor,
        hoverColor: widget.hoverColor,
        overlayColor: widget.overlayColor,
        splashRadius: widget.splashRadius,
        materialTapTargetSize: widget.materialTapTargetSize,
        visualDensity: widget.visualDensity,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        shape: widget.shape,
        side: widget.side,
        isError: widget.isError,
        enabled: widget.enabled,
        tileColor: widget.tileColor,
        title: widget.title,
        subtitle: widget.subtitle,
        isThreeLine: widget.isThreeLine,
        dense: widget.dense,
        secondary: widget.secondary,
        selected: widget.selected,
        controlAffinity: widget.controlAffinity,
        contentPadding: widget.contentPadding,
        tristate: widget.tristate,
        checkboxShape: widget.checkboxShape,
        selectedTileColor: widget.selectedTileColor,
        onFocusChange: widget.onFocusChange,
        enableFeedback: widget.enableFeedback,
        checkboxSemanticLabel: widget.checkboxSemanticLabel);
  }
}
