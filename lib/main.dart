import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:restful_solid_bloc/src/domain/service_locator.dart';
import 'src/app.dart';
import 'src/domain/anime_tags.dart';

void main() async {
  GetItServiceLocator().getItSetup();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('data');
  final lastTagData = box.get('lastTag');
  if (lastTagData != null) {
    GetIt.I<IAnimeTags>().setLastTag = Map<String, dynamic>.from(lastTagData);
  }
  runApp(
    const MainApp(),
  );
}
