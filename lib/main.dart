import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:restful_solid_bloc/src/domain/service_locator.dart';
import 'src/app.dart';

void main() async {
  GetItServiceLocator().getItSetup();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox(
    'data',
  );
  runApp(
    const MainApp(),
  );
}
