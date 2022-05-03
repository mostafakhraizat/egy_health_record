import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../edit_user/edit_chronic.dart';
import '../edit_user/edit_drugs.dart';
import '../edit_user/edit_operations.dart';
import '../edit_user/edit_viruses.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key, required this.number}) : super(key: key);
  final String number;
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  List<Object?> selected = [];
  FirebaseDatabase databse = FirebaseDatabase.instance;
  ValueNotifier<List<String>> viruses_vaccines = ValueNotifier([]);
  ValueNotifier<List<String>> operations = ValueNotifier([]);
  ValueNotifier<List<String>> chronic = ValueNotifier([]);
  ValueNotifier<List<String>> drugs = ValueNotifier([]);
  ValueNotifier<List<String>> steve = ValueNotifier(['asd']);

  List<MultiSelectItem> viruses_items = [];
  List<MultiSelectItem> chronic_items = [];
  List<MultiSelectItem> operation_items = [];
  List<MultiSelectItem> drugs_items = [];
  List<MultiSelectItem> steveitems = [];

  @override
  void initState() {
    getDrugs();
    setState(() {
      steveitems = steve.value
          .map((animal) =>
              MultiSelectItem<String>(animal.toString(), animal.toString()))
          .toList();
    });
    getChronic();
    getOperations();
    getVirusesAndVaccines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('تعديل مواطن'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Column(
                  children: [
                    const Text(
                      'البيانات الطبية كاملة',
                      style: TextStyle(
                        decoration: TextDecoration.overline,
                      ),
                    ),
                    Divider(),
                    Text(widget.number,style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),),

                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "الامراض المزمنة",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.2)),
              child: FutureBuilder(
                  future: getChronic(),
                  builder: (context, snapshot) {
                return  ListTile(
                  title:const Text('الامراض المزمنة'),
                  subtitle:  Text(chronic_items.length.toString()),
                  trailing:const Text('تعديل'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditChronic(id:widget.number)));
                  },
                );
              }),
            ),
            const SizedBox(
              height: 12,
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "اللقاحات والأوبئة",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.2)),
              child: FutureBuilder(
                  future: getVirusesAndVaccines(),
                  builder: (context, snapshot) {
                    return  ListTile(
                      title:const Text('الاوبئة واللقلحات'),
                      subtitle:  Text(viruses_items.length.toString()),
                      trailing:const Text('تعديل'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditViruses(id:widget.number)));
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 12,
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "العمليات الجراحية",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.2)),
              child: FutureBuilder(
                  future: getOperations(),
                  builder: (context, snapshot) {
                    return  ListTile(
                      title:const Text('العمليات الجراحية'),
                      subtitle:  Text(operation_items.length.toString()),
                      trailing:const Text('تعديل'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOperations(id:widget.number)));
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 12,
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "ألادوية العلاجية للمريض",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green.withOpacity(0.2)),
              child: FutureBuilder(
                  future: getDrugs(),
                  builder: (context, snapshot) {
                    return  ListTile(
                      title:const Text('الادوية الخاصة بالمريض'),
                      subtitle:  Text(drugs_items.length.toString()),
                      trailing:const Text('تعديل'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDrugs(id:widget.number)));
                      }
                    );
                  }),
            ),

          ],
        ),
      ),
    ));
  }

  Future<void> getVirusesAndVaccines() async {
    final ref = databse.reference()
        .child('UserData')
        .child(widget.number)
        .child('VirusesAndVaccines');
    ref.get().then((value) {
      final snapshot = value.children.iterator;
      viruses_vaccines.value.clear();
      while (snapshot.moveNext()) {
        print(snapshot.current.value);
        setState(() {
          viruses_vaccines.value.add(snapshot.current.value.toString());
        });
      }
    });

    setState(() {
      viruses_items = viruses_vaccines.value
          .map((animal) =>
          MultiSelectItem<String>(animal.toString(), animal.toString()))
          .toList();
    });
    print(viruses_vaccines.value.length);
  }

  Future<void> getChronic() async {

    final ref = databse.reference()
        .child('UserData')
        .child(widget.number)
        .child('ChronicDiseases');
    ref.get().then((value) {
      final snapshot = value.children.iterator;
      chronic.value.clear();
      while (snapshot.moveNext()) {
        setState(() {
          chronic.value.add(snapshot.current.value.toString());
        });
      }
    });

    setState(() {
      chronic_items = chronic.value
          .map((animal) =>
              MultiSelectItem<String>(animal.toString(), animal.toString()))
          .toList();
    });
  }

  Future<void> getOperations() async {

    final ref = databse.reference()
        .child('UserData')
        .child(widget.number)
        .child('Operations');
    ref.get().then((value) {
      final snapshot = value.children.iterator;
      operations.value.clear();
      while (snapshot.moveNext()) {
        setState(() {
          operations.value.add(snapshot.current.value.toString());
        });
      }
    });

    setState(() {
      operation_items = operations.value
          .map((animal) =>
          MultiSelectItem<String>(animal.toString(), animal.toString()))
          .toList();
    });
  }

  Future<void> getDrugs() async {

    final ref = databse.reference()
        .child('UserData')
        .child(widget.number)
        .child('Drugs');
    ref.get().then((value) {
      final snapshot = value.children.iterator;
      drugs.value.clear();
      while (snapshot.moveNext()) {
        setState(() {
          drugs.value.add(snapshot.current.value.toString());
        });
      }
    });

    setState(() {
      drugs_items = drugs.value
          .map((animal) =>
          MultiSelectItem<String>(animal.toString(), animal.toString()))
          .toList();
    });
  }
}
