part of 'student_dashboard_screen.dart';

extension _StudentDashboardAcademicSections on DashboardScreen {
  Widget _buildAcademicGrid(
    BuildContext context,
    AuthState auth,
    bool isArabic,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      padding: EdgeInsets.zero,
      children: [
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.fileText,
          title: t.students.transcript,
          onTap: () => context.push('/transcript'),
          color: Colors.blueAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.trendingUp,
          title: t.students.courses,
          onTap: () => context.push('/progress'),
          color: Colors.greenAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.target,
          title: t.students.action_plan,
          onTap: () => context.push('/action-plan'),
          color: Colors.purpleAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.award,
          title: t.students.subject_results,
          onTap: () => context.push('/subject-result'),
          color: Colors.orangeAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewProfile,
          icon: LucideIcons.graduationCap,
          title: t.students.digital_id,
          onTap: () => context.push('/digital-id'),
          color: Colors.indigoAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewSchedule,
          icon: LucideIcons.calendar,
          title: t.students.daily_schedule,
          onTap: () => context.push('/schedule'),
          color: Colors.deepPurpleAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewAttendance,
          icon: LucideIcons.clipboardCheck,
          title: t.students.attendance,
          onTap: () => context.push('/attendance'),
          color: Colors.redAccent,
        ),
        _gatedGrid(
          context,
          auth: auth,
          permission: RolePermission.viewSchedule,
          icon: LucideIcons.fileSpreadsheet,
          title: t.students.exam_schedule,
          onTap: () => context.push('/exam-schedule'),
          color: Colors.amberAccent,
        ),
      ],
    );
  }

  Widget _buildEnrollmentGrid(
    BuildContext context,
    AuthState auth,
    bool isArabic,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      padding: EdgeInsets.zero,
      children: [
        _gatedHorizontal(
          context,
          auth: auth,
          permission: RolePermission.enrollCourses,
          icon: LucideIcons.fileText,
          title: t.students.registration,
          onTap: () => context.push('/registration'),
          color: Colors.tealAccent,
        ),
        _gatedHorizontal(
          context,
          auth: auth,
          permission: RolePermission.viewGrades,
          icon: LucideIcons.alertCircle,
          title: t.students.invoices,
          onTap: () => context.push('/invoices'),
          color: Colors.deepOrangeAccent,
        ),
        _gatedHorizontal(
          context,
          auth: auth,
          permission: RolePermission.enrollCourses,
          icon: LucideIcons.creditCard,
          title: t.students.payment,
          onTap: () => context.push('/payment'),
          color: Colors.pinkAccent,
        ),
      ],
    );
  }

  Widget _buildUtilitiesRow(
    BuildContext context,
    AuthState auth,
    bool isArabic,
  ) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          _buildSquareItem(
            context,
            LucideIcons.helpCircle,
            t.students.tutorials,
            () => context.push('/tutorials'),
            Colors.blueGrey,
            auth: auth,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.fingerprint,
            t.students.security,
            () => context.push('/biometrics'),
            Colors.redAccent,
            auth: auth,
            permission: RolePermission.viewProfile,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.bell,
            t.students.notifications,
            () => context.push('/notifications'),
            Colors.amberAccent,
            auth: auth,
            permission: RolePermission.viewNotifications,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.messageSquare,
            t.students.forums,
            () => context.push('/forums'),
            Colors.cyanAccent,
            auth: auth,
            permission: RolePermission.accessForums,
          ),
          const SizedBox(width: 12),
          _buildSquareItem(
            context,
            LucideIcons.lifeBuoy,
            t.students.support,
            () => context.push('/support'),
            Colors.indigoAccent,
            auth: auth,
            permission: RolePermission.submitSupportTicket,
          ),
        ],
      ),
    );
  }

  Widget _gatedGrid(
    BuildContext context, {
    required AuthState auth,
    required RolePermission permission,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    final locked = !auth.hasPermission(permission);
    return _buildGridItem(context, icon, title, onTap, color, locked: locked);
  }

  Widget _gatedHorizontal(
    BuildContext context, {
    required AuthState auth,
    required RolePermission permission,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    final locked = !auth.hasPermission(permission);
    return _buildHorizontalItem(
      context,
      icon,
      title,
      onTap,
      color,
      locked: locked,
    );
  }
}
