import 'package:flutter/material.dart';

class AppColors
{
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Colors.black;
  static const Color yellow = Color(0xFFF0D005);
  static const Color red = Color(0xFFE00404);

  static const Color magrezaGrave = Color(0xFFE09900);
  static const Color magrezaModerada = Color(0xFFF5BE47);
  static const Color magrezaLeve = Color(0xFF47f558);
  static const Color pesoIdeal = Color(0xFF06C219);
  static const Color sobrepeso = Color(0xFF038A10);
  static const Color obesidadeGrau1 = Color(0xFFF52A3E);
  static const Color obesidadeGrau2 = Color(0xFFFC031C);
  static const Color obesidadeGrau3 = Color(0xFF91000F);
}

class AppTextStyles
{
  static const TextStyle titleCobraKai = TextStyle(
    color: AppColors.yellow,
    fontSize: 22,
    fontFamily: 'Stock',
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: AppColors.black,
        offset: Offset(2, 2),
      ),
    ],
  );

  static ButtonStyle roundedButton(Color backgroundColor)
  {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
    );
  }

  static ButtonStyle roundedButtonWithShadow(Color backgroundColor)
  {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: 6,
      shadowColor: Colors.black.withAlpha((0.4 * 255).toInt()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
    );
  }
}

class AppSpacing
{
  static const double logoTopPadding = 30;
  static const double logoLeftPadding = 12;
  static const double logoRightPadding = 12;
  static const double logoBottomPadding = 15;
}
