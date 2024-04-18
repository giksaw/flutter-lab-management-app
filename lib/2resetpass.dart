import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';
import 'package:mini/loginSingupPage.dart';

class VerifyAndResetPassword extends StatefulWidget {
   final String email;
  const VerifyAndResetPassword({Key? key,required this.email}) :super(key: key);

  @override
  State<VerifyAndResetPassword> createState() => _VerifyAndResetPasswordState();
}

class _VerifyAndResetPasswordState extends State<VerifyAndResetPassword> {
  late TextEditingController otpController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
                  _buildOTPField(otpController),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(newPasswordController, 'New Password'),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(confirmPasswordController, 'Confirm Password'),
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
                        'Reset Password',
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

  Widget _buildOTPField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(217, 217, 217, 10),
          labelText: 'Enter OTP',
          prefixIcon: const Icon(Icons.security),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(217, 217, 217, 10),
          labelText: labelText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _resetPassword(BuildContext context) async {
    var otp = otpController.text;
    var newPassword = newPasswordController.text;
    var confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('New password and confirm password do not match.'),
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
      return;
    }
    var email=widget.email;
    var pdata = {"email":email,"otp": otp, "newPassword": newPassword};

    try {
      var response = await Api.verifyOTP(pdata);
     

      print("Message: $response");

      if (response == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Password reset successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    MaterialPageRoute(
                          builder: (context) =>
                               const LoginSignup());
                   // Navigate back to the previous page
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
              content: Text("invalid OTP"),
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