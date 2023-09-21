import {Dimensions} from 'react-native';

const {height} = Dimensions.get('screen');

export const BASE = 16;

const SIZES = {
  BASE: BASE,
  FONT: BASE,
  OPACITY: 0.6,
  BORDER_RADIUS: 4,
  BORDER_WIDTH: 0.8,

  // Typography
  H1: BASE * 2.75,
  H2: BASE * 2.375,
  H3: BASE * 1.875,
  H4: BASE * 1.5,
  H5: BASE * 1.3125,
  H6: BASE * 1.125,
  BODY: BASE * 0.875,
  SMALL: BASE * 0.75,

  // Icons
  ICON: BASE,
  ICON_MEDIUM: BASE * 1.5,
  ICON_LARGE: BASE * 2,

  // Button styles
  BUTTON_WIDTH: BASE * 9,
  BUTTON_HEIGHT: BASE * 2.75,
  BUTTON_SHADOW_RADIUS: 3,

  // Block styles
  BLOCK_SHADOW_OPACITY: 0.25,
  // 0.15
  BLOCK_SHADOW_RADIUS: 8,
  ANDROID_ELEVATION: 1,

  // Card styles
  CARD_BORDER_RADIUS: BASE * 0.4,
  CARD_BORDER_WIDTH: BASE * 0.05,
  CARD_MARGIN_VERTICAL: BASE * 0.875,
  CARD_FOOTER_HORIZONTAL: BASE * 0.75,
  CARD_FOOTER_VERTICAL: BASE * 0.75,
  CARD_AVATAR_WIDTH: BASE * 2.5,
  CARD_AVATAR_HEIGHT: BASE * 2.5,
  CARD_AVATAR_RADIUS: BASE * 1.25,
  CARD_IMAGE_HEIGHT: BASE * 12.5,
  CARD_ROUND: BASE * 0.1875,
  CARD_ROUNDED: BASE * 0.5,

  // Input styles
  INPUT_BORDER_RADIUS: BASE * 0.5,
  INPUT_BORDER_WIDTH: BASE * 0.05,
  INPUT_HEIGHT: BASE * 2.75,
  INPUT_HORIZONTAL: BASE,
  INPUT_VERTICAL_TEXT: 14,
  INPUT_VERTICAL_LABEL: BASE / 2,
  INPUT_TEXT: BASE * 0.875,
  INPUT_ROUNDED: BASE * 1.5,

  // NavBar styles
  NAVBAR_HEIGHT: BASE * 4.125,
  NAVBAR_VERTICAL: BASE,
  NAVBAR_TITLE_FLEX: 2,
  NAVBAR_TITLE_HEIGHT: height * 0.07,
  NAVBAR_TITLE_TEXT: BASE * 0.875,
  NAVBAR_LEFT_FLEX: 0.5,
  NAVBAR_LEFT_HEIGHT: height * 0.07,
  NAVBAR_LEFT_MARGIN: BASE,
  NAVBAR_RIGHT_FLEX: 0.5,
  NAVBAR_RIGHT_HEIGHT: height * 0.07,
  NAVBAR_RIGHT_MARGIN: BASE,

  // Checkbox
  CHECKBOX_WIDTH: 20,
  CHECKBOX_HEIGHT: 20,

  // Slider
  TRACK_SIZE: 4,
  THUMB_SIZE: 25,

  // Radio Button
  RADIO_WIDTH: 24,
  RADIO_HEIGHT: 24,
  RADIO_THICKNESS: 2,
};

export default SIZES;