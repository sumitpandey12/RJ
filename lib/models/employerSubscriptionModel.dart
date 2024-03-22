class EmployerSubscriptionModel {
  String? planName;
  String? text;
  bool? visible;
  int? validityInDays;
  int? price;
  int? discountedPrice;
  int? contactCredit;
  int? interestCredit;
  int? jobPostCredit;

  EmployerSubscriptionModel(
      {this.planName,
      this.text,
      this.visible,
      this.validityInDays,
      this.price,
      this.discountedPrice,
      this.contactCredit,
      this.interestCredit,
      this.jobPostCredit});

  EmployerSubscriptionModel.fromJson(Map<String, dynamic> json) {
    planName = json['Plan_Name'];
    text = json['Text'];
    visible = json['Visible'];
    validityInDays = json['Validity_in_days'];
    price = json['Price'];
    discountedPrice = json['Discounted_Price'];
    contactCredit = json['Contact_Credit'];
    interestCredit = json['Interest_Credit'];
    jobPostCredit = json['Job_Post_Credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Plan_Name'] = this.planName;
    data['Text'] = this.text;
    data['Visible'] = this.visible;
    data['Validity_in_days'] = this.validityInDays;
    data['Price'] = this.price;
    data['Discounted_Price'] = this.discountedPrice;
    data['Contact_Credit'] = this.contactCredit;
    data['Interest_Credit'] = this.interestCredit;
    data['Job_Post_Credit'] = this.jobPostCredit;
    return data;
  }
}
