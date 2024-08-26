// class CountryListModel {
//   List<Data>? data;

//   CountryListModel({required this.data});

//   CountryListModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }

//     return data;
//   }
// }

// class Data {
//   int? identifier;
//   int? counryId;
//   String? apidomain;
//   String? title;
//   String? countryCode2;
//   String? countryCode3;
//   String? langcode;
//   String? icon;

//   Data({
//     required this.identifier,
//     required this.counryId,
//     required this.apidomain,
//     required this.title,
//     required this.countryCode2,
//     required this.countryCode3,
//     required this.langcode,
//     required this.icon,
//   });

//   Data.fromJson(Map<String, dynamic> json) {
//     identifier = json['identifier'];
//     counryId = json['counryId'];
//     apidomain = json['apidomain'];
//     title = json['title'];
//     countryCode2 = json['country_code2'];
//     countryCode3 = json['country_code3'];
//     langcode = json['langcode'];
//     icon = json['icon'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['identifier'] = this.identifier;
//     data['counryId'] = this.counryId;
//     data['apidomain'] = this.apidomain;
//     data['title'] = this.title;
//     data['country_code2'] = this.countryCode2;
//     data['country_code3'] = this.countryCode3;
//     data['langcode'] = this.langcode;
//     data['icon'] = this.icon;
//     return data;
//   }
// }

class CountryListModel {
  int? identifier;
  int? counryId;
  String? apidomain;
  String? title;
  String? countrycode2;
  String? countrycode3;
  String? langcode;
  String? icon;

  CountryListModel(
      {this.identifier,
      this.counryId,
      this.apidomain,
      this.title,
      this.countrycode2,
      this.countrycode3,
      this.langcode,
      this.icon});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    counryId = json['counryId'];
    apidomain = json['apidomain'];
    title = json['title'];
    countrycode2 = json['country_code2'];
    countrycode3 = json['country_code3'];
    langcode = json['langcode'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['identifier'] = identifier;
    data['counryId'] = counryId;
    data['apidomain'] = apidomain;
    data['title'] = title;
    data['country_code2'] = countrycode2;
    data['country_code3'] = countrycode3;
    data['langcode'] = langcode;
    data['icon'] = icon;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination?.fromJson(json['pagination'])
        : null;
  }
}

class Pagination {
  int? total;
  int? count;
  int? perpage;
  int? currentpage;
  int? totalpages;

  Pagination(
      {required this.total,
      required this.count,
      required this.perpage,
      required this.currentpage,
      required this.totalpages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perpage = json['per_page'];
    currentpage = json['current_page'];
    totalpages = json['total_pages'];
  }
}

class Root {
  List<CountryListModel?>? data;
  Meta? meta;

  Root({this.data, this.meta});

  Root.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CountryListModel>[];
      json['data'].forEach((v) {
        data!.add(CountryListModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta?.fromJson(json['meta']) : null;
  }
}
