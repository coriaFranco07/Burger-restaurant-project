import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final bool iconVisible;
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.color,
    required this.iconVisible,
    this.icon,
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconVisible && icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8), // Espacio entre el ícono y el texto
          ],
          Text(
            text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
