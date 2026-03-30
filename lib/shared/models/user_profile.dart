/// User profile model mapped from Supabase 'profiles' table
class UserProfile {
  final String id;
  final String? name;
  final String? avatarUrl;
  final String status;
  final int yarasBalance;
  final DateTime? updatedAt;

  // Level Logic (Computed or static for now)
  int get yarasToNextLevel => 2000 - yarasBalance;
  int get nextLevelTarget => 2000;
  String get nextLevelName => 'Embaixador';
  double get progressPercent => yarasBalance / nextLevelTarget;

  const UserProfile({
    required this.id,
    this.name,
    this.avatarUrl,
    required this.status,
    required this.yarasBalance,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      status: json['status'] as String? ?? 'MEMBRO',
      yarasBalance: json['yaras_balance'] as int? ?? 0,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'status': status,
      'yaras_balance': yarasBalance,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static const UserProfile sample = UserProfile(
    id: 'sample-user',
    name: 'Mário Vilanculo',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
    status: 'Platinum',
    yarasBalance: 1250,
  );
}
