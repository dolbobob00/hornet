import 'package:flutter/material.dart';

import 'package:restful_solid_bloc/src/domain/service_locator.dart';
import 'src/app.dart';

void main() async {
  GetItServiceLocator().getItSetup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MainApp(),
  );
}
