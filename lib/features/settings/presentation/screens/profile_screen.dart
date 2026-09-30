import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

part 'profile_editing_sections.dart';
part 'profile_display_sections.dart';
part 'profile_fields.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;
  bool _isLoaded = false;
  bool _isUploadingAvatar = false;

  File? _selectedImage;
  late final AnimationController _glowController;

  void _updateState(VoidCallback callback) => setState(callback);

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      value: 0.5,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _nationalIdController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _loadProfile() {
    if (_isLoaded) return;
    final auth = ref.read(authControllerProvider);
    final profile = auth.profile;
    _nameController.text = profile?.fullName ?? '';
    _phoneController.text = profile?.phone ?? '';
    _bioController.text = profile?.bio ?? '';
    _nationalIdController.text = profile?.nationalId ?? '';
    _isLoaded = true;
  }

  @override
  Widget build(BuildContext context) => _buildProfileScreen(context);
}
