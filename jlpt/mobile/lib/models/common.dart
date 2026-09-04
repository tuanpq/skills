const List<String> jlptLevels = ['N5', 'N4', 'N3', 'N2', 'N1'];

const Map<String, String> skillLabels = {
  'VOCABULARY': 'Từ vựng',
  'GRAMMAR': 'Ngữ pháp',
  'READING': 'Đọc hiểu',
  'LISTENING': 'Nghe hiểu',
};

const Map<String, String> studyStatusLabels = {
  'NEW': 'Mới',
  'LEARNING': 'Đang học',
  'MASTERED': 'Đã thuộc',
};

class ApiPage<T> {
  final List<T> content;

  ApiPage({required this.content});

  factory ApiPage.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiPage<T>(
      content: (json['content'] as List<dynamic>)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
