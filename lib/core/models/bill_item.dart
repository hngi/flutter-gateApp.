class BillItem {
  int estateBillId;
  String item;
  String iconLink;
  int baseAmount;

  BillItem({
    this.estateBillId,
    this.item,
    this.iconLink,
    this.baseAmount,
  });

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
        estateBillId: json['estate_bill_id'],
        item: json['item'],
        iconLink: json['icon_link'],
        baseAmount: json['base_amount']);
  }
}
