import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 60,
              child: ClipOval(
                child: Image.network(
                  'https://media-exp1.licdn.com/dms/image/C4D03AQHC_9HwMDd03g/profile-displayphoto-shrink_100_100/0/1516928511897?e=1638403200&v=beta&t=ttGpl6b8chpdAgjNjBRmNEm4LxZAkJWq8OTQtd92VIg',
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
          Text('ANDREI ERMENEU', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
