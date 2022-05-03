import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class EditChronic extends StatefulWidget {
  const EditChronic({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _EditChronicState createState() => _EditChronicState();
}

class _EditChronicState extends State<EditChronic> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                Center(
                  child: InkWell(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'اضافة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('اختر مرض مزمن'),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: FirebaseAnimatedList(
                                  query: FirebaseDatabase.instance
                                      .reference()
                                      .child('Data')
                                      .child('ChronicDiseases'),
                                  itemBuilder:
                                      (context, snapshot, animation, index) {
                                    final json = snapshot.value;
                                    return Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: ListTile(
                                            title: Text(json.toString()),
                                            onTap: () {
                                              FirebaseDatabase database =
                                                  FirebaseDatabase.instance;
                                              database
                                                  .ref('UserData')
                                                  .child(widget.id)
                                                  .child('ChronicDiseases')
                                                  .push()
                                                  .set(json.toString());
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'تمت الاضافة بنجاح!')));
                                            },
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
              title: const Text('تعديل الامراض المزمنة'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(widget.id + '  : الامراض المزمنة المواطن')),
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: FirebaseDatabase.instance
                        .reference()
                        .child('UserData')
                        .child(widget.id)
                        .child('ChronicDiseases'),
                    itemBuilder: (context, snapshot, animation, index) {
                      final json = snapshot.value;
                      return Column(
                        children: [
                          Container(
                            decoration:BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: ListTile(
                              title: Text(json.toString()),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
