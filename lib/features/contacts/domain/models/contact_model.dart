class ContactModel {
  final String name;
  final String status;
  final String? avatarUrl;
  final bool isOnline;
  final bool isAppUser;

  ContactModel({
    required this.name,
    required this.status,
    this.avatarUrl,
    this.isOnline = false,
    this.isAppUser = true,
  });
}