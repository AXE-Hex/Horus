import 'package:flutter/material.dart';

Widget build(Widget? trailing) {
  return Row(children: [if (trailing != null) trailing!]);
}
