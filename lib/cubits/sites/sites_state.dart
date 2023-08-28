import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/status.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SiteState extends Equatable {
  final String statusText;
  final SiteModel siteModel;
  SiteModel? siteDetail;
  final List<SiteModel> sites;
  final FormStatus status;

  SiteState({
    required this.siteModel,
    this.siteDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.sites,
  });

  SiteState copyWith({
    String? statusText,
    SiteModel? siteModel,
    SiteModel? siteDetail,
    List<SiteModel>? sites,
    FormStatus? status,
  }) =>
      SiteState(
        siteDetail: siteDetail ?? this.siteDetail,
        siteModel: siteModel ?? this.siteModel,
        sites: sites ?? this.sites,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
    siteModel,
    sites,
    statusText,
    status,
    siteDetail,
  ];

  bool canAddWebsite() {
    if (siteModel.image.isEmpty) return false;
    if (siteModel.name.isEmpty) return false;
    if (siteModel.link.isEmpty) return false;
    if (siteModel.author.isEmpty) return false;
    if (siteModel.contact.isEmpty) return false;
    if (siteModel.hashtag.isEmpty) return false;
    return true;
  }
}