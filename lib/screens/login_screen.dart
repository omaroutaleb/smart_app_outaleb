
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connexion")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/logo emsi.jpeg', height: 120),
            SizedBox(height: 16),
            Text('Bienvenue!', style: TextStyle(fontSize: 24, color: Colors.green)),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implement login functionality
                Navigator.pushReplacementNamed(
                  context, '/home', arguments: emailController.text,
                );
              },
              child: Text("Se connecter"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
            ),
            TextButton(
              child: Text('Pas de compte? Inscrivez-vous ici', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
