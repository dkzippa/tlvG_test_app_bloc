import 'package:app_01/bloc/missions_bloc.dart';
import 'package:app_01/bloc/missions_events.dart';
import 'package:app_01/widgets/astronaut_animation.dart';
import 'package:app_01/widgets/drawer_custom.dart';
import 'package:app_01/widgets/missions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_config.dart';

class PageSearch extends StatefulWidget {
  const PageSearch({Key? key}) : super(key: key);

  @override
  _PageSearchState createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  final _searchInputController = TextEditingController();
  final GlobalKey<FormState> _searchFormKey = GlobalKey<FormState>();
  String? inputError;

  @override
  void initState() {
    super.initState();

    _searchInputController.addListener(() {
      if (_searchInputController.text.length > 0 && _searchInputController.text.length <= AppConfig.minTextLength) {
        setState(() {
          inputError = 'Please type correct mission name, (min ${AppConfig.minTextLength} symbols)';
        });
      } else {
        setState(() {
          inputError = '';

          MissionsBloc bloc = BlocProvider.of<MissionsBloc>(context);

          if (bloc != null) {
            bloc.add(MissionsEventsLoading(searchStr: _searchInputController.text));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image(image: AssetImage('assets/images/spacex.png'), width: MediaQuery.of(context).size.width * 0.5),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        drawer: DrawerCustom(),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Test Task: Bloc + Paging', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: (inputError == '' || inputError == null) ? Theme.of(context).cardColor : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: _searchFormKey,
                        child: TextFormField(
                          controller: _searchInputController,
                          maxLines: 1,
                          obscureText: false,
                          textAlignVertical: TextAlignVertical.center,
                          autofocus: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            hintText: 'Search missions by name',
                            hintStyle: TextStyle(fontSize: 18, decorationThickness: 0.0, height: 1),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    if (_searchInputController.text.isNotEmpty) ...[
                      TextButton(
                        onPressed: () {
                          _searchInputController.clear();
                          Focus.of(context).unfocus();
                        },
                        child: Icon(Icons.clear, color: Colors.redAccent, size: 30.0),
                        style: TextButton.styleFrom(shape: CircleBorder(), primary: Theme.of(context).cardColor),
                      )
                    ] else ...[
                      SizedBox(height: 48.0),
                    ],
                  ],
                ),
              ),
              (_searchInputController.text.length > AppConfig.minTextLength)
                  ? MissionsList(searchStr: _searchInputController.text)
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(inputError ?? '', textAlign: TextAlign.center, style: TextStyle(color: Colors.redAccent, fontSize: 14.0)),
                          AstronautAnimation(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
