class NumberModel {
  int number;
  Type status;

  NumberModel({required this.number, required this.status});

 static List<NumberModel> listToNumberModelList(List<int> list) {
    List<NumberModel> models = [];
    for (int element in list) {
      models.add(NumberModel(number: element,
          status: (element == -1) ? Type.notFixed : Type.fixed));
    }
    return models;
  }
}

enum Type { fixed, notFixed }
