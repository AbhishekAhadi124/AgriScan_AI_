import 'package:agri_scan/core/base/base_model.dart';

class RefreshRequest extends BaseModel {
  String? refresh;

  RefreshRequest({this.refresh});

  RefreshRequest.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (refresh != null) {
      data['refresh'] = refresh;
    }
    return data;
  }
}
