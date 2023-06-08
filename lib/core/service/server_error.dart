class ServerError {
  String? type;
  String? title;
  int? status;
  String? traceId;
  Errors? errors;

  ServerError({this.type, this.title, this.status, this.traceId, this.errors});

  ServerError.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    traceId = json['traceId'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['status'] = this.status;
    data['traceId'] = this.traceId;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? breedid;
  List<String>? birthdate;

  Errors({this.breedid, this.birthdate});

  Errors.fromJson(Map<String, dynamic> json) {
    breedid = json['Breedid'].cast<String>();
    birthdate = json['Birthdate'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Breedid'] = this.breedid;
    data['Birthdate'] = this.birthdate;
    return data;
  }
}