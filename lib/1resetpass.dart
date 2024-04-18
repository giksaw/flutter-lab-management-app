import 'package:flutter/material.dart';
import 'package:mini/2resetpass.dart';
import 'package:mini/bloc/services/api.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(11, 0, 35, 10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Food Microbiology Lab',
                  style: TextStyle(
                    color: Color.fromRGBO(104, 200, 255, 10),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Chemical Utility',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Color.fromRGBO(34, 22, 102, 10),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildEmailField(emailController),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
                    ),
                    onPressed: () {
                      _resetPassword(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(11, 0, 35, 10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(217, 217, 217, 10),
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _resetPassword(BuildContext context) async {
    var email = emailController.text;

    var pdata = {"email": email};

    try {
      var response = await Api.resetPassword(pdata);

      print("Message: $response");

      if (response == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text(
                  'Password reset instructions have been sent to your email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    String email = emailController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                               VerifyAndResetPassword(email: email)),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text("Mail id doesnt exist"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error resetting password: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
