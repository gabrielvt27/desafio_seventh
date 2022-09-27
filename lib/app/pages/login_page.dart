import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginStore _loginStore = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          TextField(
            onChanged: (value) => _loginStore.user = value,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                labelText: "Usuário",
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                hintText: "Informe a senha"),
          ),
          TextField(
            onChanged: (value) => _loginStore.password = value,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                hintText: "Informe a senha"),
          ),
          ElevatedButton(
            onPressed: () {
              _loginStore.login();
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
