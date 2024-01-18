import 'package:flutter/material.dart';
import 'package:simple_chips_input/src/text_form_field_syle.dart';
import 'package:flutter/services.dart';

class MySimpleChipsInput extends StatefulWidget {

  const MySimpleChipsInput({
    super.key,
    required this.separatorCharacter,
    this.placeChipsSectionAbove = true,
    this.widgetContainerDecoration = const BoxDecoration(),
    this.marginBetweenChips =
    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
    this.paddingInsideChipContainer =
    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
    this.paddingInsideWidgetContainer = const EdgeInsets.all(8.0),
    this.chipContainerDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    this.textFormFieldStyle = const TextFormFieldStyle(),
    this.chipTextStyle = const TextStyle(color: Colors.white),
    this.focusNode,
    this.autoFocus = false,
    this.controller,
    this.createCharacter = ' ',
    this.deleteIcon,
    this.validateInput = false,
    this.validateInputMethod,
    this.eraseKeyLabel = 'Backspace',
    this.formKey,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onSaved,
    this.onChipDeleted,
    this.onChipAdded,
    this.onChipsCleared,
    this.chipsText = const [],
  });

  /// Character to seperate the output. For example: ' ' will seperate the output by space.
  final String separatorCharacter;

  /// Whether to place the chips section above or below the text field.
  final bool placeChipsSectionAbove;

  /// Decoration for the main widget container.
  final BoxDecoration widgetContainerDecoration;

  /// Margin between the chips.
  final EdgeInsets marginBetweenChips;

  /// Padding inside the chip container.
  final EdgeInsets paddingInsideChipContainer;

  /// Padding inside the main widget container;
  final EdgeInsets paddingInsideWidgetContainer;

  /// Decoration for the chip container.
  final BoxDecoration chipContainerDecoration;

  /// FocusNode for the text field.
  final FocusNode? focusNode;

  /// Controller for the textfield.
  final TextEditingController? controller;

  /// The input character used for creating a chip.
  final String createCharacter;

  /// Text style for the chip.
  final TextStyle chipTextStyle;

  /// Icon for the delete method.
  final Widget? deleteIcon;

  /// Whether to validate input before adding to a chip.
  final bool validateInput;

  /// Validation method.
  final dynamic Function(String)? validateInputMethod;

  /// The key label used for erasing a chip. Defaults to Backspace.
  final String eraseKeyLabel;

  /// Whether to autofocus the widget.
  final bool autoFocus;

  /// Form key to access or validate the form outside the widget.
  final GlobalKey<FormState>? formKey;

  /// Style for the textfield.
  final TextFormFieldStyle textFormFieldStyle;

  final List<String> chipsText;

  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function(String)? onSaved;

  /// Callback when a chip is deleted. Returns the deleted chip content and index.
  final void Function(String, int)? onChipDeleted;

  /// Callback when a chip is added. Returns the added chip content.
  final void Function(String)? onChipAdded;

  /// Callback when all chips are cleared.
  final void Function()? onChipsCleared;

  @override
  State<MySimpleChipsInput> createState() => SimpleChipsInputState();
}

class SimpleChipsInputState extends State<MySimpleChipsInput> {
  late final TextEditingController _controller;
  // ignore: prefer_typing_uninitialized_variables
  late final _formKey;
  late final FocusNode _focusNode;

  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  List<Widget> _buildChipsSection() {
    final List<Widget> chips = [];
    for (int i = 0; i < widget.chipsText.length; i++) {
      chips.add(Container(
        padding: widget.paddingInsideChipContainer,
        margin: widget.marginBetweenChips,
        decoration: widget.chipContainerDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.chipsText[i],
                style: widget.chipTextStyle,
              ),
            ),
            if (widget.deleteIcon != null)
              GestureDetector(
                onTap: () {
                  widget.onChipDeleted?.call(widget.chipsText[i], i);
                  setState(() {
                    widget.chipsText.removeAt(i);
                  });
                },
                child: widget.deleteIcon,
              ),
          ],
        ),
      ));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: widget.paddingInsideWidgetContainer,
        decoration: widget.widgetContainerDecoration,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              if (widget.placeChipsSectionAbove) ...[
                ..._buildChipsSection(),
              ],
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) {
                  if(event is RawKeyUpEvent) {
                    return;
                  }
                  if (event.data.logicalKey.keyLabel == widget.eraseKeyLabel) {
                    if (_controller.text.isEmpty && widget.chipsText.isNotEmpty) {
                      setState(() {
                        widget.onChipDeleted?.call(widget.chipsText.last, widget.chipsText.length - 1);
                        widget.chipsText.removeLast();
                      });
                    }
                  }
                },
                child: TextFormField(
                  autofocus: widget.autoFocus,
                  focusNode: _focusNode,
                  controller: _controller,
                  keyboardType: widget.textFormFieldStyle.keyboardType,
                  maxLines: widget.textFormFieldStyle.maxLines,
                  minLines: widget.textFormFieldStyle.minLines,
                  enableSuggestions:
                  widget.textFormFieldStyle.enableSuggestions,
                  showCursor: widget.textFormFieldStyle.showCursor,
                  cursorWidth: widget.textFormFieldStyle.cursorWidth,
                  cursorColor: widget.textFormFieldStyle.cursorColor,
                  cursorRadius: widget.textFormFieldStyle.cursorRadius,
                  cursorHeight: widget.textFormFieldStyle.cursorHeight,
                  onChanged: (value) {
                    if (value.endsWith(widget.createCharacter)) {
                      _controller.text = _controller.text
                          .substring(0, _controller.text.length - 1);
                      _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length),
                      );
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          widget.chipsText.add(_controller.text);
                          widget.onChipAdded?.call(_controller.text);
                          _controller.clear();
                        });
                      }
                    }
                    widget.onChanged?.call(value);
                  },
                  decoration: widget.textFormFieldStyle.decoration,
                  validator: (value) {
                    if (widget.validateInput &&
                        widget.validateInputMethod != null) {
                      return widget.validateInputMethod!(value!);
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    widget.onEditingComplete?.call();
                  },
                  onFieldSubmitted: ((value) {
                    _output = '';
                    for (String text in widget.chipsText) {
                      _output += text + widget.separatorCharacter;
                    }
                    if (value.isNotEmpty) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          widget.chipsText.add(_controller.text);
                          widget.onChipAdded?.call(_controller.text);
                          _output +=
                              _controller.text + widget.separatorCharacter;
                          _controller.clear();
                        });
                      }
                    }
                    widget.onSubmitted?.call(_output);
                  }),
                  onSaved: (value) {
                    _output = '';
                    for (String text in widget.chipsText) {
                      _output += text + widget.separatorCharacter;
                    }
                    if (value!.isNotEmpty) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          widget.chipsText.add(_controller.text);
                          widget.onChipAdded?.call(_controller.text);
                          _output +=
                              _controller.text + widget.separatorCharacter;
                          _controller.clear();
                        });
                      }
                    }
                    widget.onSaved?.call(_output);
                  },
                ),
              ),
              if (!widget.placeChipsSectionAbove) ...[
                ..._buildChipsSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void clearChips() {
    setState(() {
      widget.chipsText.clear();
      _controller.clear();
      widget.onChipsCleared?.call();
    });
  }
}
