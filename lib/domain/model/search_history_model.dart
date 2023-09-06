class SearchHistoryModel {
  List<SearchHistoryItem> history;

  SearchHistoryModel({required this.history});

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
        history: json['items']
            .map<SearchHistoryItem>((item) => SearchHistoryItem.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['items'] = history.map((e) => e.toJson()).toList();
    return data;
  }
}

class SearchHistoryItem {
  String name;
  SearchHistoryItem({required this.name});

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) {
    return SearchHistoryItem(name: json['name']);
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
