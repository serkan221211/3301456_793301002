class satis {
  String? id;
  String? date;
  String? companyName;
  String? total;
  String? cash;
  String? card;
  String? remainder;
  List<Product>? product;

  satis(
      {this.id,
        this.date,
        this.companyName,
        this.total,
        this.cash,
        this.card,
        this.remainder,
        this.product});

  satis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    companyName = json['company_name'];
    total = json['total'];
    cash = json['cash'];
    card = json['card'];
    remainder = json['remainder'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['company_name'] = this.companyName;
    data['total'] = this.total;
    data['cash'] = this.cash;
    data['card'] = this.card;
    data['remainder'] = this.remainder;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? piece;
  String? money;
  String? sum;

  Product({this.id, this.name, this.piece, this.money, this.sum});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    piece = json['piece'];
    money = json['money'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['piece'] = this.piece;
    data['money'] = this.money;
    data['sum'] = this.sum;
    return data;
  }
}