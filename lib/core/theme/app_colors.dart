import 'package:flutter/material.dart';

class AppColors {
  // 🔵 Navy Family (Primary)
  static const Color navy950 = Color(0xFF040D1A);
  static const Color navy900 = Color(0xFF0A1730);
  static const Color navy800 = Color(0xFF0E2347);
  static const Color navy700 = Color(0xFF16294F);
  static const Color navy600 = Color(0xFF1B3A6B);
  static const Color navy500 = Color(0xFF2C4E8A);
  static const Color navy400 = Color(0xFF3A6BC4);
  static const Color navy100 = Color(0xFFE8EEFA);
  static const Color navy050 = Color(0xFFF2F5FD);

  // 🟡 Gold Family (Accent / Achievement)
  static const Color gold600 = Color(0xFFA07820);
  static const Color gold500 = Color(0xFFD4AF37);
  static const Color gold400 = Color(0xFFE8C766);
  static const Color gold300 = Color(0xFFF4E5A8);
  static const Color gold100 = Color(0xFFFBF1D8);
  static const Color gold050 = Color(0xFFFEF9EC);

  // ⚪ Neutral Family
  static const Color neutral900 = Color(0xFF111827);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral400 = Color(0xFF9CA3AF); // Added neutral-400 as per 9.3 and 10.2
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral050 = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);

  // 🟢🔴🧡 Semantic States
  static const Color success = Color(0xFF16A34A);
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color warning = Color(0xFFD97706);
  static const Color warningBg = Color(0xFFFFFBEB);
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerBg = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF2563EB);
  static const Color infoBg = Color(0xFFEFF6FF);

  // Gradients
  static const universityCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy900, navy700],
  );

  static const goldGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gold500, gold400],
  );

  static const goldTextGradient = LinearGradient(
    colors: [gold500, gold300, gold500],
    stops: [0.0, 0.5, 1.0],
  );
}
