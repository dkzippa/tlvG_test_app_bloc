import 'package:app_01/models/mission_model.dart';
import 'package:flutter/material.dart';

class MissionsListItem extends StatelessWidget {
  final MissionModel? mission;
  const MissionsListItem({@required this.mission}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 15),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: mission!.launchSuccess! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mission!.launchSuccess!
                  ? Icon(Icons.check_circle, size: 20.0, color: Colors.green)
                  : Icon(Icons.dangerous, size: 20.0, color: Colors.redAccent),
              SizedBox(width: 6),
              Expanded(
                  child: Text(mission!.name!,
                      style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)),
              Text(mission!.launchYear!, style: TextStyle(color: Colors.white, fontSize: 15.0)),
            ], //
          ),
          SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Text(mission!.details!, style: TextStyle(color: Colors.white, fontSize: 14.0))),
              if (mission!.details!.isNotEmpty) ...[
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image(image: NetworkImage('https://spaceholder.cc/60x60?${mission!.id}'), width: 60, height: 60),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
