import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/network/site_service.dart';

class SiteRepository {
  final SiteService siteService;

  SiteRepository({required this.siteService});

  Future<UniversalData> getSites() async =>
      await siteService.getSites();

  Future<UniversalData> getSiteById(int id) async =>
      await siteService.getSiteById(id);

  Future<UniversalData> createSite(SiteModel site) async =>
      siteService.createSite(siteModel: site);

}
