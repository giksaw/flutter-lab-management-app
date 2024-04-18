// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mini/1resetpass.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool isLoginMode = true;
  late TextEditingController usernameController;
  late TextEditingController securityqnController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscureText = true;
  bool rememberPassword = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    usernameController = TextEditingController();
    securityqnController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleMode() {
    setState(() {
      isLoginMode = !isLoginMode;
    });
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!isLoginMode) {
                          toggleMode();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, bottom: 10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            color:
                                isLoginMode ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: isLoginMode ? Colors.white : Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isLoginMode) {
                          toggleMode();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40, bottom: 10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            color:
                                isLoginMode ? Colors.transparent : Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: isLoginMode ? Colors.blue : Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final slide = Tween<Offset>(
                  begin: isLoginMode ? const Offset(-1, 0) : const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: slide,
                  child: child,
                );
              },
              child: isLoginMode ? _buildLoginForm() : _buildSignupForm(),
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

  Widget _buildLoginForm() {
    return Column(
      key: ValueKey<bool>(isLoginMode),
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Welcome Back !',
            style: TextStyle(
                color: Color.fromRGBO(34, 22, 102, 10),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        _buildTextField(usernameController, 'Email', icon: Icons.email),
        _buildPasswordField(passwordController),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Checkbox(
                value: rememberPassword,
                onChanged: (value) {
                  setState(() {
                    rememberPassword = value!;
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    rememberPassword = !rememberPassword;
                  });
                },
                child: const Text(
                  'Remember me',
                  style: TextStyle(
                    color: Color.fromRGBO(34, 22, 102, 10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Handle forgotten passwordDFSD
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResetPassword()),
                  );
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
            ),
            onPressed: () {
              _login(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      key: ValueKey<bool>(isLoginMode),
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Create an Account',
            style: TextStyle(
                color: Color.fromRGBO(34, 22, 102, 10),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        _buildTextField(usernameController, 'Username', icon: Icons.person),
        _buildTextField(emailController, 'Email', icon: Icons.email),
        _buildPasswordField(passwordController),
        _buildTextField(securityqnController, 'what is Nacl',
            icon: Icons.add_moderator_outlined),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
          ),
          onPressed: () {
            _register(context);

            // isLoginMode = false;
            // if (!isLoginMode) {
            //   toggleMode();
            // }
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Signup',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(217, 217, 217, 10),
          labelText: labelText,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
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

  void _register(BuildContext context) async {
    // var id = _idController.text;
    var name = usernameController.text;
    var email = emailController.text;
    var password = passwordController.text;
    var qn = securityqnController.text;

    if (qn != "salt") {
     showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('invalid security key'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
    } else {
      var pdata = {"username": name, "email": email, "password": password};

      try {
        var response = await Api.registerUser(pdata);
        var msg = response.getMsg();

        print("Message: $msg");

        if (msg == 'User Created') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('User created successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      isLoginMode = false;
                      if (!isLoginMode) {
                        toggleMode();
                      }
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Display a popup message with the error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(msg),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('Error registering user: $e');
        // Display a generic error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _login(BuildContext context) async {
    // var id = _idController.text;
    //  var name = usernameController.text;
    var email = usernameController.text;
    var password = passwordController.text;

    var pdata = {"email": email, "password": password};

    try {
      var response = await Api.login(pdata);
      var msg = response.getMsg();

      print("Message: $msg");

      if (msg == 'Success') {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: Text('Success'),
        //           content: Text('User created successfully!'),
        //             actions: [
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        // isLoginMode = false;
        //           if (!isLoginMode) {
        //             toggleMode();
        //           }

        //                 },
        //                 child: Text('OK'),
        //               ),
        //             ],
        //           );
        //     },
        //   );

        if (rememberPassword) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        // Display a popup message with the error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(msg),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error registering user: $e');
      // Display a generic error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  // Future<void> _loginUser(BuildContext context) async {
  //   // Your login logic
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', true);

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Homepage()),
  //   );
  // }
}

void main() {
  runApp(const MaterialApp(
    home: LoginSignup(),
  ));
}
