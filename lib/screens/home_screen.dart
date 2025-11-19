import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? "user";
    return Scaffold(
      appBar: AppBar(title: Text("Accueil")),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Smart App'),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Photo-PRO.jpeg'),
              ),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Fruits Classifier'),
              onTap: () => Navigator.pushNamed(context, '/classifier'),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('EMSI Chatbot'),
              onTap: () {}, // todo
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {}, // todo
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {}, // todo
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/img.png', height: 120),
            SizedBox(height: 10),
            Text('Bienvenue dans Smart App!', style: TextStyle(fontSize: 24, color: Colors.green)),
            Text(email),
            SizedBox(height: 18),
            ElevatedButton.icon(
              icon: Icon(Icons.dashboard),
              label: Text("Classifier des Fruits"),
              onPressed: () => Navigator.pushNamed(context, '/classifier'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
            ),
          ],
        ),
      ),
    );
  }
}