class UpdateCheckState {
  final bool isChecking;
  final bool hasUpdate;
  final String? currentVersion;
  final String? latestVersion;
  final String? updateUrl;
  final String? releaseNotes;
  final bool forceUpdate;
  final String? error;
  const UpdateCheckState({
    this.isChecking = false,
    this.hasUpdate = false,
    this.currentVersion,
    this.latestVersion,
    this.updateUrl,
    this.releaseNotes,
    this.forceUpdate = false,
    this.error,
  });
  UpdateCheckState copyWith({
    bool? isChecking,
    bool? hasUpdate,
    String? currentVersion,
    String? latestVersion,
    String? updateUrl,
    String? releaseNotes,
    bool? forceUpdate,
    String? error,
  }) {
    return UpdateCheckState(
      isChecking: isChecking ?? this.isChecking,
      hasUpdate: hasUpdate ?? this.hasUpdate,
      currentVersion: currentVersion ?? this.currentVersion,
      latestVersion: latestVersion ?? this.latestVersion,
      updateUrl: updateUrl ?? this.updateUrl,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      error: error,
    );
  }
}