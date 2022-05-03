import 'dart:convert';

import 'package:egy_health_record/admin/update_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../edit_user/edit_notes.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  String user = '';
  int found = 0;
  GlobalKey<FormState> key = GlobalKey();
  String id = '', nationality = '', fullname = '', place = '';
  FirebaseDatabase database = FirebaseDatabase.instance;
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('تعديل مستخدم'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 6, right: 6),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue)),
                child: Form(
                  key: key,
                  child: TextFormField(
                    controller: idController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل الرقم القومي';
                      }
                    },
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: "ابحث الرقم القومي",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      FirebaseDatabase datbase = FirebaseDatabase.instance;
                      final ref = datbase.ref('Users');
                      final a = ref.child(idController.text).get();
                      a.then((value) {
                        if (value.value == null) {
                          setState(() {
                            found = -1;
                          });
                        } else {
                          setState(() {
                            found = 1;
                            user = value.value.toString();
                            Map<String, dynamic> data =
                                jsonDecode(jsonEncode(value.value));
                            id = data['id'];
                            nationality = data['nationality'];
                            place = data['place'];
                            fullname = data['fullname'];
                          });
                          getDrugs(id);
                        }
                      });
                    }
                  },
                  child: const Text('Search', style: TextStyle(fontSize: 22)))
            ]),
            const SizedBox(
              height: 22,
            ),
            found == 1
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          SizedBox(width: 12),
                          Text('النتائج'),
                          SizedBox(
                            width: 22,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child:Row(
                                      children: const[
                                        Text(''),
                                        Icon(Icons.check,color: Colors.green,)
                                      ],
                                    )
                                  ),
                                  Text(id + '   :الرقم القومي')
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(fullname + '   :الاسم الكامل'),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(place + '   :المحافظة'),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(nationality + '   :الجنسية '),
                              Center(
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (a)=>UpdateUser(number: idController.text,)));
                                }, child: const Text('تعديل')),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Divider(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child:  ListTile(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (c){
                              return EditNotes(id: id,);
                            }));
                          },
                          title:const Text('الملاحظات'),
                          subtitle: FutureBuilder(
                            future: getDrugs(id),
                            builder: (context,snapshot) {
                             
                              return  Text(number.toString());
                            }
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)
                        ),
                      )
                    ],
                  )
                : found == -1
                    ? const Text('المواطن غير موجود')
                    : Container()
          ],
        ),
      ),
    ));
  }

  Future<void> getDrugs(id) async {
  
    final ref = database.reference()
        .child('UserData')
        .child(id)
        .child('Notes');
    ref.get().then((value) {
      final snapshot = value.children.iterator;
      number=0;
      setState(() {
        while(snapshot.moveNext()){
          number++;
        }
      });
    });
  }
}
