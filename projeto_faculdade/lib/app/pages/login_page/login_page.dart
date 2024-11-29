import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/login_button.dart';
import '../home_page/home_page.dart';
import 'signup_page.dart';
import '../../providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              'Task Loop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
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

          // Campo de Email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Email',
              isPassword: false,
              controller: userProvider.emailController, // Usando o controller do provider
            ),
          ),
          const SizedBox(height: 20.0),

          // Campo de Senha
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CustomTextField(
              hintText: 'Senha',
              isPassword: true,
              controller: userProvider.passwordController, // Usando o controller do provider
            ),
          ),
          const SizedBox(height: 30.0),

          // Botão de Login
          LoginButton(
            onPressed: () async {
              final email = userProvider.emailController.text;
              final senha = userProvider.passwordController.text;

              try {
                // Realiza o login com os dados fornecidos
                final user = await userProvider.login(email, senha);

                if (context.mounted) {
                  // Login bem-sucedido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bem-vindo(a), ${user.name}!')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: user), // Passa o usuário autenticado
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  // Erro durante o login
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
          ),

          const SizedBox(height: 20.0),

          // Link para cadastro
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: const Text(
              "Não tem uma conta? Crie uma nova",
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
