import 'package:app_01/bloc/missions_bloc.dart';
import 'package:app_01/bloc/missions_events.dart';

import 'package:app_01/bloc/missions_state.dart';
import 'package:app_01/widgets/astronaut_animation.dart';
import 'package:app_01/widgets/missions_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionsList extends StatefulWidget {
  final String? searchStr;
  const MissionsList({Key? key, this.searchStr}) : super(key: key);

  @override
  _MissionsListState createState() => _MissionsListState();
}

class _MissionsListState extends State<MissionsList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('ssss');

        int curOffset = 0;
        if (BlocProvider.of<MissionsBloc>(context).state is MissionsStateLoaded) {
          curOffset = (BlocProvider.of<MissionsBloc>(context).state as MissionsStateLoaded).missions!.length;
          print('ssss curOffset: ' + curOffset.toString());
        }

        BlocProvider.of<MissionsBloc>(context).add(MissionsEventsLoadingMore(offset: curOffset));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MissionsBloc, MissionsState>(builder: (context, state) {
        if (state is MissionsStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is MissionsStateError) {
          return Center(child: Text("Error: " + state.error.toString()));
        }

        if (state is MissionsStateLoaded) {
          if (state.missions!.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text('No matches found. Please choose another names, for example "Falc", "Star", etc',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                  AstronautAnimation(),
                ],
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.missions!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int idx) {
                  return MissionsListItem(mission: state.missions![idx]);
                },
              ),
            );
          }
        }

        return Center(child: AstronautAnimation()); // empty
      }),
    );
  }
}
