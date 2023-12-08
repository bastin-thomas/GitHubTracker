import 'package:flutter/material.dart';

const double cDefaultWidth = 36;
const double cDefaultSpacer = 17;

List<BoxShadow> cBoxShadowItem = [
  BoxShadow(
    color: Colors.black.withOpacity(0.16),
    blurRadius: 4,
    offset: const Offset(3, 3),
  )
];

const double kHorizontalSpacer = 16;
const double kVerticalSpacer = 26;

const kMainBackgroundColor = Colors.black87;
const kCardPopupBackgroundColor = Colors.black54;

final kBoxDecoration = BoxDecoration(
    color: kCardPopupBackgroundColor,
    boxShadow: kBoxShadowItem,
    borderRadius: kBorderRadiusItem
);

const BorderRadius kBorderRadiusItem = BorderRadius.all(Radius.circular(10));

List<BoxShadow> kBoxShadowItem = [
  BoxShadow(
    color: Colors.black.withOpacity(0.16),
    blurRadius: 4,
    offset: const Offset(3, 3),
  )
];

const appScheme = 'flutterdemo';
