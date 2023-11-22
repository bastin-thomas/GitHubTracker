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

const String kGitHubToken = "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";
const appScheme = 'flutterdemo';

const Auth0_Domain = 'dev-dywnisq364dw45je.eu.auth0.com';
const Auth0_ClientId = 'lx9LYRJVLecqhSzuuVMCg3cmNoRLMmLq';
const Auth0_ClientSecret = 'iOIg4rbjOOxpwRPLj1tzhi9G3yvYAfAed2gqHXinjs0jxGz9IMBG7S6Qm6vYDPYP';

const String GitApp_ClientSecret = '5b87d7aa6baef0a3ef55db0e30fdd06a36133a0c';
const String GitApp_ClientId = 'f1b94682cbc0e1191117';
