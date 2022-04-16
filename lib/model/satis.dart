class satis {
  String? company;
  String? date;
  String? total;
  List<Product>? product;

  satis({this.company, this.date, this.total, this.product});

  satis.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    date = json['date'];
    total = json['total'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['date'] = this.date;
    data['total'] = this.total;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? name;
  String? piece;
  String? money;
  String? sum;

  Product({this.name, this.piece, this.money, this.sum});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    piece = json['piece'];
    money = json['money'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['piece'] = this.piece;
    data['money'] = this.money;
    data['sum'] = this.sum;
    return data;
  }
}