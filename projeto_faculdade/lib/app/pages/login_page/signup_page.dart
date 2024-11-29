import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/login_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título
          const Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              'Cadastro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.black54,
                  ),
                  Shadow(
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 4.0,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Campo de Nome
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Nome',
              isPassword: false,
              controller: userProvider.nameController,
            ),
          ),
          const SizedBox(height: 20.0),

          // Campo de Email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Email',
              isPassword: false,
              controller: userProvider.emailController,
            ),
          ),
          const SizedBox(height: 20.0),

          // Campo de Senha
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Senha',
              isPassword: true,
              controller: userProvider.passwordController,
            ),
          ),
          const SizedBox(height: 20.0),

          // Campo de Confirmar Senha
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Confirmar Senha',
              isPassword: true,
              controller: userProvider.confirmPasswordController,
            ),
          ),
          const SizedBox(height: 30.0),

          // Botão de Registrar
          LoginButton(
            onPressed: () async {
              try {
                await userProvider.addPessoa();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuário registrado com sucesso!')),
                  );
                  Navigator.pop(context); 
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              }
            },
            text: 'Registrar',
          ),

          const SizedBox(height: 20.0),

          // Voltar para Login
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Já tem uma conta? Faça login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
