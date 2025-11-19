import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inscription")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/logo emsi.jpeg', height: 120),
            SizedBox(height: 16),
            Text('Créer un compte', style: TextStyle(fontSize: 24, color: Colors.green)),
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
            SizedBox(height: 10),
            TextField(
              controller: confirmController,
              decoration: InputDecoration(
                labelText: 'Confirmer mot de passe',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implement registration logic/validation here
                Navigator.pushReplacementNamed(
                  context, '/home', arguments: emailController.text,
                );
              },
              child: Text("S'inscrire"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            TextButton(
              child: Text('Déjà un compte? Connectez-vous ici', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}