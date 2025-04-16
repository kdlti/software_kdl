import 'package:excel/excel.dart' as ex;

var headerStyle = ex.CellStyle(
  fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
  bold: true,
  fontSize: 10,
  horizontalAlign: ex.HorizontalAlign.Left,
  verticalAlign: ex.VerticalAlign.Center,
  rotation: 0,
  underline: ex.Underline.None,
  italic: false,
);

var borderStyle = ex.CellStyle(
  topBorder: ex.Border(borderStyle: ex.BorderStyle.Thin),
  leftBorder: ex.Border(borderStyle: ex.BorderStyle.Thin),
  rightBorder: ex.Border(borderStyle: ex.BorderStyle.Thin),
  bottomBorder: ex.Border(borderStyle: ex.BorderStyle.Thin),
);
