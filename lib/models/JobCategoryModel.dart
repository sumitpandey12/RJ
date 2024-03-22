class JobCategoryModel {
  int? categoryID;
  String? category;
  String? categoryHindi;
  String? photo;

  JobCategoryModel(
      {this.categoryID, this.category, this.categoryHindi, this.photo});

  JobCategoryModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['Category_ID'];
    category = json['Category'];
    categoryHindi = json['Category_Hindi'];
    photo = json['Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category_ID'] = this.categoryID;
    data['Category'] = this.category;
    data['Category_Hindi'] = this.categoryHindi;
    data['Photo'] = this.photo;
    return data;
  }
}
