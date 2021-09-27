import 'package:app_01/screens/screen_search.dart';

import 'package:app_01/services/missions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/missions_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Task - Bloc With Paging',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => MissionsBloc(
          repository: MissionsRepository(),
        ),
        child: PageSearch(),
      ),
    );
  }
}
