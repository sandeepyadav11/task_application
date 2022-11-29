




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_application/Screens/second_screen.dart';

void main(List<String> args) {
  runApp(const TaskApp()
  
  );
}

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  @override
 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Task Application",
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login "),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 163, 226, 255),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      RegExp regExp = new RegExp(patttern);
                      if (value!.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value!)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Mobile Number',
                    ),
                    maxLength: 10,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(const ButtonScreen());
                        print("Success");
                      } else {
                        print("UnSuccessful");
                      }
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
