import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 Login Page',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  String imageSource = 'images/question-mark.jpg';

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _loadLoginInfo();
  }

  // Load saved login and password if available
  void _loadLoginInfo() async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    String? savedLogin = await prefs.getString("LoginName");
    String? savedPassword = await prefs.getString("Password");

    if (savedLogin.isNotEmpty && savedPassword.isNotEmpty) {
      setState(() {
        _loginController.text = savedLogin;
        _passwordController.text = savedPassword;
      });

      // Show snackbar after build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Previous login loaded.")),
        );
      });
    }
  }

  // Show dialog to save or discard login info
  void _handleLogin() async {
    String password = _passwordController.text;
    String loginName = _loginController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save Login Info"),
          content: const Text("Would you like to save your login and password for next time?"),
          actions: [
            TextButton(
              onPressed: () async {
                EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
                await prefs.setString("LoginName", loginName);
                await prefs.setString("Password", password);

                Navigator.of(context).pop(); // Close dialog
                _updateImage(password);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () async {
                EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
                await prefs.clear();

                Navigator.of(context).pop(); // Close dialog
                _updateImage(password);
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  // Determine which image to show based on password
  void _updateImage(String password) {
    setState(() {
      if (password == 'QWERTY123') {
        imageSource = 'images/light-bulb.jpg';
      } else {
        imageSource = 'images/stop-sign.jpg';
      }
    });
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Image.asset(
              imageSource,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
