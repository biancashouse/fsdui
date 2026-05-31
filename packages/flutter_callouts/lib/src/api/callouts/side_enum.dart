enum SideEnum {
  TOP,
  RIGHT,
  BOTTOM,
  LEFT
}

SideEnum previousSide(SideEnum side) {
  switch(side) {
    case SideEnum.TOP:
      return SideEnum.LEFT;
    case SideEnum.RIGHT:
      return SideEnum.TOP;
    case SideEnum.BOTTOM:
      return SideEnum.RIGHT;
    case SideEnum.LEFT:
      return SideEnum.BOTTOM;
  }
}

SideEnum nextSide(SideEnum side) {
  switch(side) {
    case SideEnum.TOP:
      return SideEnum.RIGHT;
    case SideEnum.RIGHT:
      return SideEnum.BOTTOM;
    case SideEnum.BOTTOM:
      return SideEnum.LEFT;
    case SideEnum.LEFT:
      return SideEnum.TOP;
  }
}

// Side oppositeSide(Side theSide) {
//   switch (theSide) {
//     case Side.BOTTOM:
//       return Side.TOP;
//     case Side.LEFT:
//       return Side.RIGHT;
//     case Side.RIGHT:
//       return Side.LEFT;
//     case Side.TOP:
//       return Side.BOTTOM;
//   }
// }