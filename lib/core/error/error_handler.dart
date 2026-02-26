
import 'package:flutter/material.dart';
import 'package:hue/core/error/app_exception.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorHandler {
  static void showError(BuildContext context, dynamic error) {
    String code = 'SYS-999';
    String message = 'An unexpected system error occurred.';

    if (error is AppException) {
      code = error.code;
      message = error.message;
    } else {
      debugPrint('Unknown Error: $error');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade900,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.security, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SYSTEM ALERT: $code',
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.redAccent.shade100,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
