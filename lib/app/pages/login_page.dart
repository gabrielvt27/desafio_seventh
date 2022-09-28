import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_seventh/app/stores/login_store.dart';
import 'package:desafio_seventh/app/utils/api_response.dart';
import 'package:desafio_seventh/app/pages/components/error_message_widget.dart';
import 'package:desafio_seventh/app/pages/components/default_button_widget.dart';
import 'package:desafio_seventh/app/pages/components/custom_text_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginStore _loginStore = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFieldWidget(
                labelText: "Usuário",
                hintText: "Informe o usuário",
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 30,
                  color: Color(0xffA6B0BD),
                ),
                onChanged: (value) => _loginStore.user = value,
              ),
              CustomTextFieldWidget(
                labelText: "Senha",
                hintText: "Informe a senha",
                obscureText: true,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 30,
                  color: Color(0xffA6B0BD),
                ),
                onChanged: (value) => _loginStore.password = value,
              ),
              DefaultButtonWidget(
                text: "LOGIN",
                onPressed: () => _loginStore.login(),
              ),
              Center(
                child: ValueListenableBuilder<ApiResponse>(
                  valueListenable: _loginStore.loginState,
                  builder: (context, value, child) {
                    if (value.status == Status.error) {
                      return ErrorMessageWidget(message: value.message!);
                    } else if (value.status == Status.loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
