import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Viruses extends StatefulWidget {
  const Viruses({Key? key}) : super(key: key);

  @override
  _VirusesState createState() => _VirusesState();
}

class _VirusesState extends State<Viruses> {
  int textLength = 0;
  TextEditingController virusController = TextEditingController();

  @override
  void dispose() {
    virusController.dispose();
    super.dispose();
  }

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
          title: const Text('اللقاحات والاوبئة'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'اضافة وباء او لقاح',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        content: Form(
                          key: _key,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.toString() == '') {
                                return 'أدخل اسم لقاح او وباء';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            controller: virusController,
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'وباء او لقاح',
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    color: Colors.grey[900]!, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('الغاء'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                FirebaseDatabase database =
                                    FirebaseDatabase.instance;
                                database
                                    .ref('Data')
                                    .child('VirusesAndVaccines')
                                    .push()
                                    .set(virusController.text.toString());
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('اضافة'),
                          ),
                        ],
                        semanticLabel: 'asda',
                      );
                    }
                  );
                },
                icon: const Icon(Icons.add)),

          ]),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .reference()
                  .child('Data')
                  .child('VirusesAndVaccines'),
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
