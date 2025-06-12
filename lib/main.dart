import 'package:flutter/material.dart';
import 'data_repository.dart';
import 'profilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 Login Page',
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
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load saved data at startup
    DataRepository.loadData().then((_) {
      // Set login field from loaded data
      _loginController.text = DataRepository.loginName;
      // Optional: set password field if you saved it (not recommended for security)
      setState(() {});
    });
  }

  void _handleLogin() {
    final loginName = _loginController.text.trim();
    final password = _passwordController.text;

    if (password == 'QWERTY123') {
      // Save loginName in repo and prefs
      DataRepository.loginName = loginName;
      DataRepository.saveData();

      // Navigate to profile page and show snackbar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      ).then((_) {
        // Optional: do something on return
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back $loginName')),
      );
    } else {
      // Wrong password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong Password')),
      );
    }
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
              decoration: const InputDecoration(labelText: 'Login Name'),
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
          ],
        ),
      ),
    );
  }
}
