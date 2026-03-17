import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/shared/data/notification_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final UserProfileModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  late UserProfileModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  UsersController get _controller =>
      ref.read(usersControllerProvider().notifier);

  void _sendAdminNotification(String title, String message) {
    ref
        .read(notificationControllerProvider.notifier)
        .addNotification(
          AppNotification(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            message: message,
            timestamp: DateTime.now(),
            category: NotificationCategory.security,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final primaryColor = Theme.of(context).primaryColor;
    final roleName = _user.roles.isNotEmpty
        ? _user.roles.first.displayName(isArabic: isArabic)
        : '—';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.extracted.user_details,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.pencil, size: 18),
            onPressed: () async {
              final result = await context.push<bool>(
                '/admin/users/edit',
                extra: _user,
              );
              if (result == true && context.mounted) {
                context.pop();
              }
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Profile Header
                _buildProfileHeader(primaryColor, roleName, isArabic),
                const SizedBox(height: 20),

                // ── Status Overview
                _buildStatusGrid(primaryColor),
                const SizedBox(height: 20),

                // ── Quick Actions
                _buildSectionTitle(
                  LucideIcons.zap,
                  t.extracted.quick_actions,
                  Colors.amberAccent,
                ),
                const SizedBox(height: 14),
                _buildQuickActions(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Verification
                _buildSectionTitle(
                  LucideIcons.shieldCheck,
                  t.extracted.verification,
                  const Color(0xFF10B981),
                ),
                const SizedBox(height: 14),
                _buildVerificationCard(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Ban Management
                _buildSectionTitle(
                  LucideIcons.ban,
                  t.extracted.ban_management,
                  const Color(0xFFEF4444),
                ),
                const SizedBox(height: 14),
                _buildBanCard(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Tags
                _buildSectionTitle(
                  LucideIcons.tag,
                  t.extracted.tags,
                  const Color(0xFF6366F1),
                ),
                const SizedBox(height: 14),
                _buildTagsCard(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Warning Level
                _buildSectionTitle(
                  LucideIcons.alertTriangle,
                  t.extracted.warning_level,
                  Colors.orangeAccent,
                ),
                const SizedBox(height: 14),
                _buildWarningCard(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Account Status
                _buildSectionTitle(
                  LucideIcons.power,
                  t.extracted.account_status,
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(height: 14),
                _buildAccountStatusCard(primaryColor, isArabic),
                const SizedBox(height: 24),

                // ── Danger Zone
                _buildSectionTitle(
                  LucideIcons.alertOctagon,
                  t.extracted.danger_zone,
                  const Color(0xFFEF4444),
                ),
                const SizedBox(height: 14),
                _buildDangerZone(primaryColor, isArabic),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.02, end: 0);
  }

  Widget _buildProfileHeader(
    Color primaryColor,
    String roleName,
    bool isArabic,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(28),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withValues(alpha: 0.4),
                      primaryColor.withValues(alpha: 0.1),
                    ],
                  ),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.15),
                    width: 3,
                  ),
                ),
                child: _user.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          _user.avatarUrl!,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            LucideIcons.user,
                            size: 36,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : Icon(
                        LucideIcons.user,
                        size: 36,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _user.isActive ? Color(0xFF10B981) : Color(0xFFEF4444),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        (Theme.of(context).cardTheme.color ??
                        Theme.of(context).cardColor),
                    width: 3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Name
          Text(
            _user.fullName,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          if (_user.fullNameAr != null && _user.fullNameAr!.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              _user.fullNameAr!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
          SizedBox(height: 8),
          // Email
          Text(
            _user.email,
            style: GoogleFonts.shareTechMono(
              fontSize: 13,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 14),
          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              roleName,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Badges row
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_user.isVerified)
                _buildBadge(
                  LucideIcons.badgeCheck,
                  t.extracted.verified,
                  const Color(0xFF10B981),
                ),
              if (_user.isBanned)
                _buildBadge(
                  LucideIcons.ban,
                  t.extracted.banned,
                  const Color(0xFFEF4444),
                ),
              if (_user.mfaEnabled)
                _buildBadge(LucideIcons.shield, 'MFA', Colors.blueAccent),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale(
      begin: const Offset(0.97, 0.97),
      end: const Offset(1, 1),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusGrid(Color primaryColor) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoTile(
            LucideIcons.hash,
            _user.studentId ?? '—',
            t.admin.student_id,
            const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildInfoTile(
            LucideIcons.phone,
            _user.phone ?? '—',
            t.admin.phone_number,
            const Color(0xFF10B981),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.04, end: 0);
  }

  Widget _buildInfoTile(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(Color primaryColor, bool isArabic) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: LucideIcons.power,
            label: _user.isActive
                ? (t.extracted.deactivate)
                : (t.extracted.activate),
            color: _user.isActive ? Color(0xFFF59E0B) : Color(0xFF10B981),
            onTap: () => _toggleStatus(isArabic),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildActionCard(
            icon: _user.isVerified
                ? LucideIcons.shieldOff
                : LucideIcons.shieldCheck,
            label: _user.isVerified
                ? (t.extracted.unverify)
                : (t.extracted.verify),
            color:
                (Theme.of(context).cardTheme.color ??
                Theme.of(context).cardColor),
            onTap: () => _toggleVerification(isArabic),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildActionCard(
            icon: _user.isBanned ? LucideIcons.unlock : LucideIcons.ban,
            label: _user.isBanned ? (t.extracted.unban) : (t.extracted.ban),
            color:
                (Theme.of(context).cardTheme.color ??
                Theme.of(context).cardColor),
            onTap: () => _toggleBan(isArabic),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.04, end: 0);
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  // ── Verification Card
  Widget _buildVerificationCard(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _user.isVerified
                  ? Color(0xFF10B981).withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
            ),
            child: Icon(
              _user.isVerified ? LucideIcons.badgeCheck : LucideIcons.shieldOff,
              size: 22,
              color: _user.isVerified
                  ? Color(0xFF10B981)
                  : Colors.white.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user.isVerified
                      ? (t.extracted.account_verified)
                      : (t.extracted.not_verified),
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _user.isVerified
                      ? (t.extracted.user_identity_has_been_verified)
                      : (t.extracted.identity_not_yet_verified),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          _buildToggleButton(
            isActive: _user.isVerified,
            activeColor: const Color(0xFF10B981),
            onTap: () => _toggleVerification(isArabic),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.04, end: 0);
  }

  // ── Ban Card
  Widget _buildBanCard(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      border: _user.isBanned
          ? Border.all(
              color:
                  (Theme.of(context).cardTheme.color ??
                          Theme.of(context).cardColor)
                      .withValues(alpha: 0.3),
              width: 1.5,
            )
          : null,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _user.isBanned
                  ? Color(0xFFEF4444).withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
            ),
            child: Icon(
              _user.isBanned ? LucideIcons.ban : LucideIcons.checkCircle2,
              size: 22,
              color: _user.isBanned
                  ? Color(0xFFEF4444)
                  : Colors.white.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user.isBanned
                      ? (t.extracted.user_banned)
                      : (t.extracted.not_banned),
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _user.isBanned ? Color(0xFFEF4444) : Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _user.isBanned
                      ? (t.extracted.user_cannot_access_the_system)
                      : (t.extracted.user_has_normal_access),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          _buildToggleButton(
            isActive: _user.isBanned,
            activeColor: const Color(0xFFEF4444),
            onTap: () => _toggleBan(isArabic),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.04, end: 0);
  }

  // ── Tags Card
  Widget _buildTagsCard(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_user.tags.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  t.extracted.no_tags_assigned,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _user.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (Theme.of(context).cardTheme.color ??
                                Theme.of(context).cardColor)
                            .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          (Theme.of(context).cardTheme.color ??
                                  Theme.of(context).cardColor)
                              .withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.tag,
                        size: 12,
                        color:
                            (Theme.of(context).cardTheme.color ??
                            Theme.of(context).cardColor),
                      ),
                      SizedBox(width: 6),
                      Text(
                        tag,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              (Theme.of(context).cardTheme.color ??
                              Theme.of(context).cardColor),
                        ),
                      ),
                      SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _removeTag(tag, isArabic),
                        child: Icon(
                          LucideIcons.x,
                          size: 12,
                          color:
                              (Theme.of(context).cardTheme.color ??
                                      Theme.of(context).cardColor)
                                  .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showAddTagDialog(isArabic),
              icon: Icon(LucideIcons.plus, size: 16),
              label: Text(
                t.extracted.add_tag,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF6366F1),
                side: BorderSide(
                  color:
                      (Theme.of(context).cardTheme.color ??
                              Theme.of(context).cardColor)
                          .withValues(alpha: 0.3),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.04, end: 0);
  }

  // ── Warning Card
  Widget _buildWarningCard(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.extracted.current_level,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Text(
                '${_user.warningLevel}/4',
                style: GoogleFonts.shareTechMono(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: _user.warningLevel > 2
                      ? const Color(0xFFEF4444)
                      : (_user.warningLevel > 0
                            ? Colors.orangeAccent
                            : Colors.white30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Warning bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _user.warningLevel / 4,
              backgroundColor: Colors.white.withValues(alpha: 0.06),
              color: _user.warningLevel > 2
                  ? const Color(0xFFEF4444)
                  : (_user.warningLevel > 0
                        ? Colors.orangeAccent
                        : const Color(0xFF10B981)),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final isActive = _user.warningLevel >= index;
              return GestureDetector(
                onTap: () => _setWarningLevel(index, isArabic),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.orangeAccent.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive
                          ? Colors.orangeAccent.withValues(alpha: 0.4)
                          : Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: GoogleFonts.shareTechMono(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: isActive
                            ? Colors.orangeAccent
                            : Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.04, end: 0);
  }

  // ── Account Status Card
  Widget _buildAccountStatusCard(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        children: [
          _buildDetailRow(
            LucideIcons.calendar,
            t.extracted.created,
            _formatDate(_user.createdAt),
          ),
          if (_user.lastLogin != null)
            _buildDetailRow(
              LucideIcons.logIn,
              t.extracted.last_login,
              _formatDate(_user.lastLogin!),
            ),
          _buildDetailRow(
            LucideIcons.globe,
            t.extracted.nationality,
            _user.nationality ?? '—',
          ),
          _buildDetailRow(
            LucideIcons.creditCard,
            t.extracted.national_id,
            _user.nationalId ?? '—',
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.04, end: 0);
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ── Danger Zone
  Widget _buildDangerZone(Color primaryColor, bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color:
            (Theme.of(context).cardTheme.color ?? Theme.of(context).cardColor)
                .withValues(alpha: 0.2),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _confirmDeleteUser(isArabic, hardDelete: false),
              icon: Icon(LucideIcons.userX, size: 16),
              label: Text(
                t.extracted.soft_delete_deactivate,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orangeAccent,
                side: BorderSide(
                  color: Colors.orangeAccent.withValues(alpha: 0.3),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _confirmDeleteUser(isArabic, hardDelete: true),
              icon: Icon(LucideIcons.trash2, size: 16),
              label: Text(
                t.extracted.permanently_delete,
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).scaffoldBackgroundColor.withValues(alpha: 0.15),
                foregroundColor: const Color(0xFFEF4444),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.04, end: 0);
  }

  Widget _buildToggleButton({
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 300.ms,
        width: 52,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isActive
              ? activeColor.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.08),
          border: Border.all(
            color: isActive
                ? activeColor.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: AnimatedAlign(
          duration: 300.ms,
          alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeColor
                  : Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // ── Action Methods

  void _toggleVerification(bool isArabic) {
    final newVal = !_user.isVerified;
    _showConfirmDialog(
      title: newVal
          ? (t.extracted.verify_account)
          : (t.extracted.remove_verification),
      message: newVal
<<<<<<< HEAD
          ? (t.extracted.verify_userfullname(user_fullName: _user.fullName) + "'s account?")
          : (t.extracted.remove_verification_from_userfullname(user_fullName: _user.fullName)),
=======
          ? (t.extracted.verify__userfullname(___________a__: _user.fullName)s account?')
          : (t.extracted.remove_verification_from__userfullname(___________a__: _user.fullName)),
>>>>>>> f29febc6c2601dcf99a1375e4a425e08782e6021
      confirmColor: const Color(0xFF10B981),
      onConfirm: () {
        _controller.toggleVerification(_user.id, newVal);
        setState(() => _user = _user.copyWith(isVerified: newVal));
        _sendAdminNotification(
          newVal ? 'Account Verified' : 'Verification Removed',
          '${_user.fullName} was ${newVal ? "verified" : "unverified"} by admin.',
        );
        _showSuccessSnackBar(
          isArabic
              ? (newVal ? 'تم التوثيق بنجاح' : 'تم إلغاء التوثيق')
              : (newVal ? 'Verified successfully' : 'Verification removed'),
        );
      },
    );
  }

  void _toggleBan(bool isArabic) {
    final newVal = !_user.isBanned;
    _showConfirmDialog(
      title: newVal ? (t.extracted.ban_user) : (t.extracted.unban_user),
      message: newVal
<<<<<<< HEAD
          ? (t.extracted.ban_userfullname_they_will_lose_system_access(user_fullName: _user.fullName))
          : (t.extracted.unban_userfullname(user_fullName: _user.fullName)),
=======
          ? (t.extracted.ban__userfullname_they_will_lose_system_access(___________a__: _user.fullName))
          : (t.extracted.unban__userfullname(___________a__: _user.fullName)),
>>>>>>> f29febc6c2601dcf99a1375e4a425e08782e6021
      confirmColor: const Color(0xFFEF4444),
      onConfirm: () {
        _controller.toggleBan(_user.id, newVal);
        setState(() => _user = _user.copyWith(isBanned: newVal));
        _sendAdminNotification(
          newVal ? 'User Banned' : 'User Unbanned',
          '${_user.fullName} was ${newVal ? "banned" : "unbanned"} by admin.',
        );
        _showSuccessSnackBar(
          isArabic
              ? (newVal ? 'تم الحظر' : 'تم إلغاء الحظر')
              : (newVal ? 'User banned' : 'User unbanned'),
        );
      },
    );
  }

  void _toggleStatus(bool isArabic) {
    final newVal = !_user.isActive;
    _controller.toggleUserStatus(_user.id, newVal);
    setState(() => _user = _user.copyWith(isActive: newVal));
    _sendAdminNotification(
      newVal ? 'Account Activated' : 'Account Deactivated',
      '${_user.fullName} was ${newVal ? "activated" : "deactivated"} by admin.',
    );
    _showSuccessSnackBar(
      isArabic
          ? (newVal ? 'تم تفعيل الحساب' : 'تم تعطيل الحساب')
          : (newVal ? 'Account activated' : 'Account deactivated'),
    );
  }

  void _setWarningLevel(int level, bool isArabic) {
    HapticFeedback.selectionClick();
    _controller.updateWarningLevel(_user.id, level);
    setState(() => _user = _user.copyWith(warningLevel: level));
    _sendAdminNotification(
      'Warning Level Changed',
      '${_user.fullName} warning level set to $level.',
    );
    _showSuccessSnackBar(t.extracted.warning_level_set_to_level(level: level));
  }

  void _removeTag(String tag, bool isArabic) {
    final newTags = List<String>.from(_user.tags)..remove(tag);
    _controller.updateTags(_user.id, newTags);
    setState(() => _user = _user.copyWith(tags: newTags));
    _showSuccessSnackBar(t.extracted.tag_removed);
  }

  void _showAddTagDialog(bool isArabic) {
    final tagController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          t.extracted.add_tag,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: tagController,
          autofocus: true,
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: t.extracted.tag_name,
            hintStyle: GoogleFonts.inter(color: Colors.white30),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              t.extracted.cancel,
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          TextButton(
            onPressed: () {
              final tag = tagController.text.trim();
              if (tag.isNotEmpty) {
                final newTags = [..._user.tags, tag];
                _controller.updateTags(_user.id, newTags);
                setState(() => _user = _user.copyWith(tags: newTags));
                _sendAdminNotification(
                  'Tag Added',
                  'Tag "$tag" added to ${_user.fullName}.',
                );
              }
              Navigator.pop(ctx);
            },
            child: Text(
              t.extracted.add,
              style: GoogleFonts.inter(
                color:
                    (Theme.of(context).cardTheme.color ??
                    Theme.of(context).cardColor),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUser(bool isArabic, {required bool hardDelete}) {
    final title = hardDelete
        ? t.extracted.permanent_delete
        : t.extracted.soft_delete;

    final message = hardDelete
        ? t.extracted
            .permanently_delete_userfullname_this_cannot_be_undone(
              user_fullName: _user.fullName,
            )
        : '${t.extracted.deactivate_userfullname(user_fullName: _user.fullName)}\'s account?';

    _showConfirmDialog(
<<<<<<< HEAD
      title: title,
      message: message,
=======
      title: hardDelete
          ? (t.extracted.permanent_delete)
          : (t.extracted.soft_delete),
      message: hardDelete
          ? (t.extracted.permanently_delete__userfullname_this_cannot_be_undone(___________a__: _user.fullName))
          : (t.extracted.deactivate__userfullname(___________a__: _user.fullName)s account?'),
>>>>>>> f29febc6c2601dcf99a1375e4a425e08782e6021
      confirmColor: const Color(0xFFEF4444),
      onConfirm: () {
        _controller.deleteUser(_user.id, hardDelete: hardDelete);
        _sendAdminNotification(
          hardDelete ? 'User Deleted' : 'User Deactivated',
          '${_user.fullName} was ${hardDelete ? "permanently deleted" : "soft deleted"} by admin.',
        );
        context.pop();
      },
    );
  }

  void _showConfirmDialog({
    required String title,
    required String message,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          message,
          style: GoogleFonts.inter(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    HapticFeedback.heavyImpact();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              LucideIcons.checkCircle,
              color: Theme.of(context).colorScheme.onSurface,
              size: 18,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
