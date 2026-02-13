import 'package:flutter/services.dart';

final NumberFormatter = FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+[\.]?[0-9]?"));