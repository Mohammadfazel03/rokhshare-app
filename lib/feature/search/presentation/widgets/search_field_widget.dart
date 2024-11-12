import 'package:flutter/material.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class SearchFieldWidget extends StatefulWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final Function(String? text)? onChange;
  final TextEditingController _controller;
  final bool showSearchIcon;
  final bool showClearIcon;
  final bool isDense;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;

  SearchFieldWidget(
      {super.key,
      TextEditingController? controller,
      this.hintText = "جستجو",
      this.hintStyle,
      this.showClearIcon = true,
      this.showSearchIcon = true,
      this.isDense = false,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      this.onChange})
      : _controller = controller ?? TextEditingController();

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        if (isEmpty != text.isEmpty) {
          setState(() {
            isEmpty = text.isEmpty;
          });
        }
        if (widget.onChange != null) {
          widget.onChange!(text);
        }
      },
      controller: widget._controller,
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      decoration: InputDecoration(
          isDense: widget.isDense,
          prefixIcon: (widget.showSearchIcon)
              ? (widget.prefixIcon != null)
                  ? widget.prefixIcon
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
                      child: Assets.icons.magniferLinear.svg(
                          alignment: Alignment.topRight,
                          fit: BoxFit.fill,
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurfaceVariant,
                              BlendMode.srcIn)),
                    )
              : null,
          prefixIconConstraints: (widget.showSearchIcon)
              ? (widget.prefixIconConstraints != null)
                  ? widget.prefixIconConstraints
                  : const BoxConstraints(
                      maxHeight: 48,
                      maxWidth: 48,
                    )
              : null,
          suffixIconConstraints: (widget.showClearIcon)
              ? (widget.suffixIconConstraints != null)
                  ? widget.suffixIconConstraints
                  : const BoxConstraints(
                      maxHeight: 48,
                      maxWidth: 48,
                    )
              : null,
          suffixIcon: (!isEmpty && widget.showClearIcon)
              ? IconButton(
                  icon: Icon(Icons.clear,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onPressed: () {
                    widget._controller.clear();
                    if (widget.onChange != null) {
                      widget.onChange!(null);
                    }
                    setState(() {
                      isEmpty = true;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          filled: true),
    );
  }
}
