part of 'users_provider.dart';

@ProviderFor(UsersController)
final usersControllerProvider = UsersControllerFamily._();

final class UsersControllerProvider
    extends $StreamNotifierProvider<UsersController, List<UserProfileModel>> {
  UsersControllerProvider._({
    required UsersControllerFamily super.from,
    required ({RoleCategory? category, UserRole? role}) super.argument,
  }) : super(
         retry: null,
         name: r'usersControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$usersControllerHash();

  @override
  String toString() {
    return r'usersControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UsersController create() => UsersController();

  @override
  bool operator ==(Object other) {
    return other is UsersControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$usersControllerHash() => r'2cd120740c29cd5af3cbdd726e74061a84a64dda';

final class UsersControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          UsersController,
          AsyncValue<List<UserProfileModel>>,
          List<UserProfileModel>,
          Stream<List<UserProfileModel>>,
          ({RoleCategory? category, UserRole? role})
        > {
  UsersControllerFamily._()
    : super(
        retry: null,
        name: r'usersControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UsersControllerProvider call({RoleCategory? category, UserRole? role}) =>
      UsersControllerProvider._(
        argument: (category: category, role: role),
        from: this,
      );

  @override
  String toString() => r'usersControllerProvider';
}

abstract class _$UsersController
    extends $StreamNotifier<List<UserProfileModel>> {
  late final _$args = ref.$arg as ({RoleCategory? category, UserRole? role});
  RoleCategory? get category => _$args.category;
  UserRole? get role => _$args.role;

  Stream<List<UserProfileModel>> build({
    RoleCategory? category,
    UserRole? role,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<UserProfileModel>>, List<UserProfileModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserProfileModel>>,
                List<UserProfileModel>
              >,
              AsyncValue<List<UserProfileModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(category: _$args.category, role: _$args.role),
    );
  }
}
