import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.backgroundImage = 'assets/images/background.jpeg',
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Define o texto como Left-to-Right
      child: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Conteúdo da tela
          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}
