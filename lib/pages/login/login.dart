
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),

      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(0),
            sliver: SliverToBoxAdapter(
              child: Text(""),
            ),
          ),
          SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
          )
        ],
      ),
    );
  }
}
