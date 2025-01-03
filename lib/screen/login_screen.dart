//login_screen.dart

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectlab/helper/api.dart';
import 'package:projectlab/helper/auth_service.dart';
import 'package:projectlab/screen/register_screen.dart';
import 'package:projectlab/screen/home_screen.dart';
import 'package:projectlab/screen/home_screen_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print('Login Google Berhasil: ${account.displayName}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Google Berhasil: ${account.displayName}'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenUser()),
        );
      }
    } catch (e) {
      print('Error Google Sign-In: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Google Gagal'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      var username = _usernameController.text;
      var password = _passwordController.text;

      var user = await tryLogin(username, password);

      if (user != null) {
        AuthService.setUser(user);

        String roleMessage = user.role == 'admin'
            ? 'Berhasil login sebagai Admin'
            : 'Berhasil login sebagai User';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(roleMessage),
            backgroundColor: Colors.green,
          ),
        );

        if (user.role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreenUser()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal, periksa username dan password Anda'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/welcome.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Username tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Password tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _register,
                  child: Text.rich(
                    TextSpan(
                      text: 'Belum punya akun? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Atau login dengan"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _handleGoogleSignIn,
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/google_logo.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign In with Google',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
