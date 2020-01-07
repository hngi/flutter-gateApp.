class Bill {
  int id;
  int usersId;
  int estateBillsId;
  dynamic usageDuration;
  int amount;
  int status;
  String createdAt;
  String updatedAt;
  BillInfo billInfo;

  Bill({
    this.id,
    this.usersId,
    this.estateBillsId,
    this.usageDuration,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.billInfo,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      usersId: json['users_id'],
      estateBillsId: json['estate_bills_id'],
      usageDuration: json['usage_duration'],
      amount: json['amount'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class BillInfo {
  int id;
  int estatesId;
  String item;
  String iconLink;
  int baseAmount;
  String createdAt;
  dynamic updatedAt;

  BillInfo({
    this.id,
    this.estatesId,
    this.item,
    this.iconLink,
    this.baseAmount,
    this.createdAt,
    this.updatedAt,
  });

  factory BillInfo.fromJson(Map<String, dynamic> json) {
    return BillInfo(
      id: json['id'],
      estatesId: json['estates_id'],
      item: json['item'],
      iconLink: json['icon_link'],
      baseAmount: json['base_amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
