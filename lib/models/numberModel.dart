class NumberModel {
  int number;
  Type status;
  bool isSelected;
  bool isCorrect;

  NumberModel(
      {required this.number,
      required this.status,
      required this.isSelected,
      required this.isCorrect});

  static List<NumberModel> listToNumberModelList(List<int> list) {
    List<NumberModel> models = [];
    for (int element in list) {
      models.add(
        NumberModel(
            number: element,
            status: (element == -1) ? Type.notFixed : Type.fixed,
            isSelected: false,
            isCorrect: false ),
      );
    }
    return models;
  }
}

enum Type { fixed, notFixed }
