import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController idController = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void dispose() {
    fullNameController.dispose();
    placeController.dispose();
    nationalityController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Add user'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        height: size.height,
        width: size.width,
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'مواطن',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      ' ,اضافة',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    controller: fullNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل الاسم الكامل';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: "الاسم الكامل",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    controller: placeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل المحافظة';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'المحافظة',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    controller: nationalityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل الجنسية';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'الجنسية',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: idController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخل الرقم القومي';
                      }else if(value.length!=14){
                        return ' الرجاء ادخل الرقم القومي الصحيح 14 رقم!';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'الرقم القومي',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.blue)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                            child: Center(
                                child: Text(
                              'رجوع',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            String place = placeController.text;
                            String id = idController.text;
                            String fullname = fullNameController.text;
                            String nationality = nationalityController.text;
                            final ref = database.ref('Users');
                            final user = <String, dynamic>{
                              'place': place,
                              'id': id,
                              "fullname": fullname,
                              "nationality": nationality,
                            };
                            ref.child(id).set(user);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.blue)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                            child: Center(
                                child: Text(
                              'أضافة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
