import 'package:columnist/cubits/sites/sites_state.dart';
import 'package:columnist/data/models/sites/sites_fields.dart';
import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/repositories/site_repository.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/utils/ui_utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiteCubit extends Cubit<SiteState> {
  SiteCubit({required this.siteRepository})
      : super(
          SiteState(
            siteModel: SiteModel(
              name: "",
              image: "",
              author: "",
              hashtag: "",
              contact: "",
              likes: "",
              link: "",
            ),
            sites: const [],
          ),
        );

  final SiteRepository siteRepository;

  createWebsite() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    UniversalData response = await siteRepository.createSite(state.siteModel);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "website_added",
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusText: response.error,
        ),
      );
    }
  }

  getSites(BuildContext context) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    showLoading(context: context);
    UniversalData response = await siteRepository.getSites();
    if (context.mounted) hideLoading(loadingContext: context);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "website_added",
          sites: response.data as List<SiteModel>,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  getSiteById(int websiteId) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    UniversalData response = await siteRepository.getSiteById(websiteId);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_website_by_id",
          siteDetail: response.data as SiteModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusText: response.error,
        ),
      );
    }
  }

  updateSiteField({
    required SiteField field,
    required dynamic value,
  }) {
    SiteModel currentSite = state.siteModel;

    switch (field) {
      case SiteField.hashtag:
        {
          currentSite = currentSite.copyWith(hashtag: value as String);
          break;
        }
      case SiteField.contact:
        {
          currentSite = currentSite.copyWith(contact: value as String);
          break;
        }
      case SiteField.link:
        {
          currentSite = currentSite.copyWith(link: value as String);
          break;
        }
      case SiteField.author:
        {
          currentSite = currentSite.copyWith(author: value as String);
          break;
        }
      case SiteField.name:
        {
          currentSite = currentSite.copyWith(name: value as String);
          break;
        }
      case SiteField.image:
        {
          currentSite = currentSite.copyWith(image: value as String);
          break;
        }
      case SiteField.likes:
        {
          currentSite = currentSite.copyWith(likes: value as String);
          break;
        }
    }

    debugPrint("WEBSITE: ${currentSite.toString()}");

    emit(state.copyWith(siteModel: currentSite, status: FormStatus.pure));
  }
}
