import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpForm(), // Ana sayfada formu göster
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Formun durumunu yönetmek için GlobalKey kullanıyoruz
  final _formKey = GlobalKey<FormState>();

  // Form alanları için controller'lar
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Formu'), // Uygulama başlığı
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Formu daha estetik hale getirmek için padding ekledik
        child: Form(
          key: _formKey, // Formun anahtarı
          child: Column(
            children: <Widget>[
              // İsim Alanı
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'İsim', // İsim alanı etiketi
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // İsim boş olamaz
                  if (value == null || value.isEmpty) {
                    return 'İsim boş olamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // Alanlar arasına boşluk ekledik

              // E-posta Alanı
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta', // E-posta alanı etiketi
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // E-posta alanının geçerli olup olmadığını kontrol ediyoruz
                  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (value == null || value.isEmpty) {
                    return 'E-posta boş olamaz';
                  } else if (!regex.hasMatch(value)) {
                    return 'Geçerli bir e-posta girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Şifre Alanı
              TextFormField(
                controller: _passwordController,
                obscureText: true, // Şifreyi gizlemek için
                decoration: InputDecoration(
                  labelText: 'Şifre', // Şifre alanı etiketi
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Şifre en az 6 karakter olmalı
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş olamaz';
                  } else if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Formu gönder butonu
              ElevatedButton(
                onPressed: () {
                  // Formun doğruluğunu kontrol et
                  if (_formKey.currentState?.validate() ?? false) {
                    // Eğer form geçerli ise
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form geçerli!')),
                    );
                  }
                },
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
