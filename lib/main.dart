import 'package:flutter/material.dart';
import 'package:business_layer/business_layer.dart';

import 'my_app.dart';

void main() {
  BlocFactory.instance.initialize();
  runApp(const MyApp());
}
