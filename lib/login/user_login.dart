import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../user/user_home.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({Key? key}) : super(key: key);

  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  int textLength = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: const Center(
                      child: Text(
                        'EGY HEALTH RECORD',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 18),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text("اهلا بك!",
                                    style: TextStyle(fontSize: 22)),
                                SizedBox(height: 16),
                                Text("تسجيل الدخول",
                                    style: TextStyle(fontSize: 22))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              child: TextFormField(
                                controller: usernameController,
                                onChanged: (value) {
                                  setState(() {
                                    textLength = value.length;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter ID';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                decoration: InputDecoration(
                                  suffixIcon: textLength > 0
                                      ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                  )
                                      : const Icon(
                                    Icons.info_outline,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'الرقم القومي',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onSaved: (String? value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30),
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      final ref = database.ref("Users");
                                      ref.child(usernameController.text)
                                          .get()
                                          .then((value) {
                                        print(value.value);
                                        if (value.value != null) {
                                          Map<String, dynamic> data =
                                          jsonDecode(jsonEncode(value.value));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (s) => UserHome(
                                                      id: data['id'].toString())));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.red,
                                              content: Text(
                                                  'الرقم القومي غير صحيح, الرجاء ادخال رقم فعلي!',style: TextStyle(color: Colors.white),)));
                                        }
                                      });
                                    }
                                  },
                                  child: Text('Login',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 80,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
