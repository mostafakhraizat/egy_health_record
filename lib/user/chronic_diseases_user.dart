import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class ChronicDiseasesUser extends StatefulWidget {
  const ChronicDiseasesUser({Key? key,required this.id}) : super(key: key);
  final String id;
  @override
  _ChronicDiseasesUserState createState() => _ChronicDiseasesUserState();
}

class _ChronicDiseasesUserState extends State<ChronicDiseasesUser> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey();
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: const Text('الامراض المزمنة'),
             ),
          body: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .reference()
                      .child('UserData').child(widget.id)
                      .child('ChronicDiseases'),
                  itemBuilder: (context, snapshot, animation, index) {
                    final json = snapshot.value;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(json.toString()),
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}