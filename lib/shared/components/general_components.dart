import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../controllers/home_controller.dart';
import '../../styles/colors.dart';

Widget defaultTextFormField({
  String textKey = 'Task',
  String floatingTextKey = 'Task',
  double height = 44,
  double? width,
  double marginRight = 0,
  double marginLeft = 0,
  double marginTop = 0,
  double marginBottom = 0,
  double textSize = 15,
  double hintSize = 15,
  double textHintHeight = 0.7,
  double borderRadius = 8,
  Color textColor = MyAppColors.black,
  Color hintColor = MyAppColors.black,
  Color floatingColor = MyAppColors.black,
  Color color = Colors.transparent,
  Color cursorColor = MyAppColors.black,
  Color borderColor = MyAppColors.black,
  Color focusBorderColor = MyAppColors.yellow,
  FontWeight textWeight = FontWeight.w500,
  FontWeight hintWeight = FontWeight.w400,
  TextInputType inputType = TextInputType.name,
  TextInputAction inputAction = TextInputAction.next,
  List<TextInputFormatter>? inputFormatters,
  required TextEditingController controller,
  required HomeController homeCtrl,
  bool isFloating = false,
  bool password = false,
  bool readOnly = false,
  bool expand = false,
  Widget? icon,
  Function(String value)? onChange,
  Function()? onTap,
  Function(String value)? onSubmit,
}) {
  return Container(
      height: height,
      color: color,
      width: width,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          right: marginRight,
          left: marginLeft,
          top: marginTop,
          bottom: marginBottom),
      child: TextFormField(
        expands: expand,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChange,
        obscureText: password,
        obscuringCharacter: '*',
        inputFormatters: inputFormatters,
        controller: controller,
        style: homeCtrl.mainTextStyle.copyWith(
          color: textColor,
          fontSize: textSize,
          fontWeight: textWeight,
          overflow: TextOverflow.ellipsis,
        ),
        textAlign: TextAlign.start,
        keyboardType: inputType,
        maxLines: expand ? null : 1,
        cursorColor: cursorColor,
        textInputAction: inputAction,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: icon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 0.5,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 0.5,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: focusBorderColor,
                  width: 1,
                )),
            hintText: textKey,
            hintStyle: homeCtrl.mainTextStyle.copyWith(
              color: hintColor.withOpacity(0.8),
              fontWeight: hintWeight,
              fontSize: hintSize,
              height: textHintHeight,
            ),
            hintMaxLines: 10),
        textAlignVertical: TextAlignVertical.top,
      ));
}

class CustomDropdown<T> extends StatefulWidget {
  final void Function(T, int) onChange;
  final List<DropdownItem<T>> items;
  final HomeController homeCtrl;
  final double marginTop;
  final double height;
  final double listRightMargin;
  final double heightOffset;
  final bool small;
  final RxInt index;
  const CustomDropdown({
    required Key key,
    required this.items,
    this.marginTop = 30,
    this.height = 44,
    this.heightOffset = -178,
    this.listRightMargin = 40,
    this.small = false,
    required this.index,
    required this.onChange,
    required this.homeCtrl,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  // int _currentIndex = ;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: Stack(
          children: [
            Container(
              height: widget.height,
              margin: EdgeInsets.only(top: widget.marginTop),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: _isOpen ? MyAppColors.yellow : MyAppColors.black,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AnimatedRotation(
                      turns: _isOpen ? -0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _isOpen ? MyAppColors.yellow : MyAppColors.black,
                      )),
                ],
              ),
            ),
            AnimatedSlide(
              duration: const Duration(milliseconds: 200),
              offset: Offset((widget.index.value == 1000) ? 0.2 : 0.1, 0.1),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          (widget.index.value == 1000 || _isOpen) ? 8.0 : 0),
                  child: (() {
                    if (widget.index.value == 1000 || _isOpen) {
                      return Text(
                        widget.small ? 'Shift' : 'Resident',
                        style: (widget.index.value == 1000 || _isOpen)
                            ? widget.homeCtrl.mainTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: MyAppColors.black.withOpacity(0.8),
                              )
                            : widget.homeCtrl.mainTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: MyAppColors.black,
                              ),
                      );
                    } else {
                      return widget.items[widget.index.value];
                    }
                  }())),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CompositedTransformFollower(
                offset: Offset(0, widget.heightOffset),
                link: _layerLink,
                showWhenUnlinked: false,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 0, right: widget.listRightMargin),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: MyAppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: MyAppColors.grey.withOpacity(0.3),
                            offset: const Offset(34, 34),
                            blurRadius: 89)
                      ],
                    ),
                    child: Material(
                      child: SizeTransition(
                        axisAlignment: 1,
                        sizeFactor: _expandAnimation,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: widget.items.asMap().entries.map((item) {
                              return InkWell(
                                onTap: () {
                                  setState(() => widget.index.value = item.key);
                                  widget.onChange(item.value.value, item.key);
                                  _toggleDropdown();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  color: item.key == widget.index.value
                                      ? MyAppColors.yellow
                                      : MyAppColors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      item.value,
                                      if (!widget.small)
                                        Text(
                                          "${widget.homeCtrl.residentsList[item.key].residentRoomNumber}",
                                          style: widget.homeCtrl.mainTextStyle
                                              .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: MyAppColors.black,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const DropdownItem(
      {required Key key, required this.value, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment mainAxisAlignment;
  final ShapeBorder shape;
  final double elevation;
  final Color backgroundColor;
  final EdgeInsets padding;
  final BoxConstraints constraints;
  final double width;
  final double height;
  final Color primaryColor;
  const DropdownButtonStyle({
    required this.mainAxisAlignment,
    required this.backgroundColor,
    required this.primaryColor,
    required this.constraints,
    required this.height,
    required this.width,
    required this.elevation,
    required this.padding,
    required this.shape,
  });
}

class DropdownStyle {
  final BorderRadius borderRadius;
  final double elevation;
  final Color color;
  final EdgeInsets padding;
  final BoxConstraints constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset offset;

  ///button width must be set for this to take effect
  final double width;

  const DropdownStyle({
    required this.constraints,
    required this.offset,
    required this.width,
    required this.elevation,
    required this.color,
    required this.padding,
    required this.borderRadius,
  });
}
