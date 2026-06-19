
class BannerInfo {
  final String title;
  final String subtitle;
  final String imageUrl;

  const BannerInfo({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory BannerInfo.fromJson(Map<String, dynamic> json) {
    return BannerInfo(
      title: (json['title'] ?? '') as String,
      subtitle: (json['subtitle'] ?? '') as String,
      imageUrl: (json['imageUrl'] ?? '') as String,
    );
  }
}
