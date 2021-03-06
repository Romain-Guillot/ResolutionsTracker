
import 'package:flutter/painting.dart';


/// Dimensions used in the app (margin, padding, font weights, etc.)
class Dimens {

  static const SCREEN_MARGIN_X = 20.0;
  static const SCREEN_MARGIN_Y = 20.0;
  static const EdgeInsets SCREEN_MARGIN = const EdgeInsets.symmetric(vertical: Dimens.SCREEN_MARGIN_Y, horizontal: Dimens.SCREEN_MARGIN_X);


  static const WELCOME_BLOCK_PADDING = 40.0;
  static const NORMAL_PADDING = 15.0;
  static const SMALL_PADDING = 7.5;


  static const SHAPE_SMALL_CORNER_RADIUS = 99.0;
  static const SHAPE_MEDIUM_CORNER_RADIUS = 9.0;
  static const SHAPE_LARGE_COMPONENT = 9.0;

  static const MENU_ICON_SIZE = 24.0;

  static const FONT_WEIGHT_LIGHT = FontWeight.w300;
  static const FONT_WEIGHT_REGULAR = FontWeight.w400;
  static const FONT_WEIGHT_BOLD = FontWeight.w700;
}