class RepositoryModel {
  List<Repository> repositories;

  RepositoryModel({required this.repositories});

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
        repositories: json['items']
            .map<Repository>((item) => Repository.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['items'] = repositories.map((e) => e.toJson()).toList();
    return data;
  }
}

class Repository {
  int id;
  String name;
  bool isFavorite;
  Repository({required this.id, required this.name, this.isFavorite = false});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
        id: json['id'],
        name: json['name'],
        isFavorite: json['isFavorite'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
