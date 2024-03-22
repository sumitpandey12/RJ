class ReferralModel {
  int? referralID;
  String? referrerName;

  ReferralModel({this.referralID, this.referrerName});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    referralID = json['Referral_ID'];
    referrerName = json['Referrer_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Referral_ID'] = this.referralID;
    data['Referrer_Name'] = this.referrerName;
    return data;
  }
}
