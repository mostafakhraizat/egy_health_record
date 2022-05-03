import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class MedicationsDrugsPage extends StatefulWidget {
  const MedicationsDrugsPage({Key? key}) : super(key: key);

  @override
  _MedicationsDrugsPageState createState() => _MedicationsDrugsPageState();
}

class _MedicationsDrugsPageState extends State<MedicationsDrugsPage> {
  int textLength = 0;
  TextEditingController chronicController = TextEditingController();

  @override
  void dispose() {
    chronicController.dispose();
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
              title: const Text('العلاجات والادوية'),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'اضافة علاج او دواء',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            content: Form(
                              key: _key,
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty || value.toString() == ''){
                                    return 'أدخل علاج او دواء';
                                  }else{
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                controller: chronicController,
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'علاج او دواء',
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
                                  if(_key.currentState!.validate()){
                                    FirebaseDatabase database =
                                        FirebaseDatabase.instance;
                                    database
                                        .ref('Data')
                                        .child('MedicationsDrugs')
                                        .push()
                                        .set(chronicController.text.toString());
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('اضافة'),
                              ),
                            ],
                            semanticLabel: 'asda',
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add))
              ]),
          body: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .reference()
                      .child('Data')
                      .child('MedicationsDrugs'),
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
