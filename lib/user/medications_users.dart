import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
class MedicationsUsers extends StatefulWidget {
  const MedicationsUsers({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _MedicationsUsersState createState() => _MedicationsUsersState();
}

class _MedicationsUsersState extends State<MedicationsUsers> {

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
              title: const Text('العلاجات والادوية'),
              actions: [
              ]),
          body: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .reference()
                      .child('UserData')
                  .child(widget.id)
                      .child('Drugs'),
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

