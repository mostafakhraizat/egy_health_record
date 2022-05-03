import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../admin/admin_home.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({Key? key}) : super(key: key);

  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  bool _obscureText = true;
  int textLength = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  String password = '', username = '';

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
          appBar: AppBar(
            elevation: 0,
            backgroundColor:const Color(0xff1d3444),
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    color: const Color(0xff1d3444),
                    child: Image.asset('assets/images/egy_logo.png',height: 100,width: 100,)),
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
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextFormField(
                                controller: usernameController,
                                onChanged: (value) {
                                  setState(() {
                                    textLength = value.length;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Username';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
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
                                  hintText: 'Username or Id',
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
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        semanticLabel: _obscureText
                                            ? 'show password'
                                            : 'hide password',
                                      ),
                                    ),
                                  ),
                                  onSaved: (String? value) {}),
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
                                      FirebaseDatabase database =
                                          FirebaseDatabase.instance;

                                      database
                                          .ref('admin')
                                          .child('password')
                                          .once()
                                          .then((dataSnapshot) {
                                        final value =
                                            dataSnapshot.snapshot.value;
                                        setState(() {
                                          password = value.toString();
                                        });
                                      });
                                      database
                                          .ref('admin')
                                          .child('username')
                                          .once()
                                          .then((dataSnapshot) {
                                        final value =
                                            dataSnapshot.snapshot.value;
                                        setState(() {
                                          username = value.toString();
                                        });
                                        if (usernameController.text ==
                                                username &&
                                            passwordController.text ==
                                                password) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'Logged In',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.green,
                                          ));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (s) {
                                            return const AdminHome();
                                          }));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'Wrong username or password',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.redAccent,
                                          ));
                                        }
                                      });
                                    }
                                  },
                                  child: Text('Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: MediaQuery.of(context).size.width - 80,
                            )
                          ]
                        )
                      ]
                    )
                  )
                    )
              ]
            )
          )
        )
      )
    );
  }
}
