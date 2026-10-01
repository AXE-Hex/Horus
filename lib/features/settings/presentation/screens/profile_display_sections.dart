part of 'profile_screen.dart';

extension _ProfileDisplaySections on _ProfileScreenState {
  Widget _buildProfileScreen(BuildContext context) {
    _loadProfile();
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final auth = ref.watch(authControllerProvider);
    final primaryColor = Theme.of(context).primaryColor;

    ImageProvider? avatarProvider;
    if (_selectedImage != null) {
      avatarProvider = FileImage(_selectedImage!);
    } else if (auth.profile?.avatarUrl != null &&
        auth.profile!.avatarUrl!.isNotEmpty) {
      avatarProvider = NetworkImage(auth.profile!.avatarUrl!);
    }

    final body = CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 340,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  LucideIcons.arrowLeft,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(
                          alpha: 0.3 + 0.2 * _glowController.value,
                        ),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    child: _isSaving
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          )
                        : Text(
                            t.extracted.save,
                            style: GoogleFonts.outfit(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1A0533),
                        primaryColor.withValues(alpha: 0.8),
                        Color(0xFF0D1B2A),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Opacity(
                    opacity: 0.06,
                    child: Icon(
                      LucideIcons.userCircle2,
                      size: 260,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),

                Positioned(
                  right: isArabic ? null : 40,
                  left: isArabic ? 40 : null,
                  top: 40,
                  child: AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, _) => Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            primaryColor.withValues(
                              alpha: 0.15 * _glowController.value,
                            ),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _glowController,
                              builder: (context, child) => Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [primaryColor, Color(0xFF10B981)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withValues(
                                        alpha:
                                            0.35 + 0.2 * _glowController.value,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF0D1B2A),
                                  ),
                                  child: _isUploadingAvatar
                                      ? SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.white
                                              .withValues(alpha: 0.08),
                                          backgroundImage: avatarProvider,
                                          child: avatarProvider == null
                                              ? Icon(
                                                  LucideIcons.userCircle2,
                                                  size: 55,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.7),
                                                )
                                              : null,
                                        ),
                                ),
                              ),
                            ).animate().scale(
                              duration: 700.ms,
                              curve: Curves.easeOutBack,
                            ),

                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _pickImage(context),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor,
                                        primaryColor.withValues(alpha: 0.8),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          (Theme.of(context).cardTheme.color ??
                                          Theme.of(context).cardColor),
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    LucideIcons.camera,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        auth.profile?.fullName ?? (t.extracted.user),
                        style: GoogleFonts.outfit(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      SizedBox(height: 4),
                      Text(
                        auth.user?.email ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ).animate().fadeIn(delay: 300.ms),
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.shield,
                              size: 13,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(width: 6),
                            Text(
                              auth.role.displayName(isArabic: isArabic),
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel(
                      t.extracted.personal_info,
                      LucideIcons.user,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.full_name,
                      controller: _nameController,
                      icon: LucideIcons.user,
                      iconColor: const Color(0xFF6366F1),
                      isGlass: isGlass,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? (t.extracted.required)
                          : null,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.email,
                      controller: TextEditingController(
                        text: auth.user?.email ?? '',
                      ),
                      icon: LucideIcons.mail,
                      iconColor: Colors.tealAccent,
                      isGlass: isGlass,
                      readOnly: true,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.phone_number,
                      controller: _phoneController,
                      icon: LucideIcons.phone,
                      iconColor: Colors.greenAccent,
                      isGlass: isGlass,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.national_id,
                      controller: _nationalIdController,
                      icon: LucideIcons.creditCard,
                      iconColor: Colors.amberAccent,
                      isGlass: isGlass,
                      readOnly: true,
                    ),
                    const SizedBox(height: 28),

                    _sectionLabel(
                      t.extracted.about_me,
                      LucideIcons.fileText,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.write_something_about_yourself,
                      controller: _bioController,
                      icon: LucideIcons.pencil,
                      iconColor: Colors.pinkAccent,
                      isGlass: isGlass,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 28),

                    _sectionLabel(
                      t.extracted.account_info,
                      LucideIcons.shield,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildAccountInfoCard(
                      context,
                      auth,
                      isArabic,
                      primaryColor,
                    ),
                    const SizedBox(height: 32),

                    _buildSaveButton(context, isArabic, primaryColor),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(resizeToAvoidBottomInset: true, body: body)
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            resizeToAvoidBottomInset: true,
            body: body,
          );
  }
}
