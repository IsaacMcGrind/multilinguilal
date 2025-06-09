class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}

final List<Language> supportedLanguages = [
  Language(code: 'en', name: 'English'),
  Language(code: 'zh', name: 'Chinese (Mandarin)'),
  Language(code: 'hi', name: 'Hindi'),
  Language(code: 'es', name: 'Spanish'),
  Language(code: 'ar', name: 'Arabic'),
  Language(code: 'bn', name: 'Bengali'),
  Language(code: 'pt', name: 'Portuguese'),
  Language(code: 'ru', name: 'Russian'),
  Language(code: 'ja', name: 'Japanese'),
  Language(code: 'fr', name: 'French'),
];