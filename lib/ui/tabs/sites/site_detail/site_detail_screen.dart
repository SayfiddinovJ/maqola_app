import 'package:cached_network_image/cached_network_image.dart';
import 'package:columnist/cubits/sites/sites_cubit.dart';
import 'package:columnist/cubits/sites/sites_state.dart';
import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiteDetailScreen extends StatefulWidget {
  const SiteDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<SiteDetailScreen> createState() => _SiteDetailScreenState();
}

class _SiteDetailScreenState extends State<SiteDetailScreen> {
  _init() {
    BlocProvider.of<SiteCubit>(context).getSiteById(widget.id);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Site detail screen'),
      ),
      body: BlocBuilder<SiteCubit, SiteState>(
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == FormStatus.failure) {
            return Center(
              child: Text(
                'Error ${state.statusText}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          SiteModel? siteModel = state.siteDetail;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${siteModel?.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  siteModel!.link,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    height: 250.h,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: baseUrl + siteModel.image.substring(1),
                      fit: BoxFit.fill,
                      errorWidget: (e1, e2, e3) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        height: 300.h,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, size: 100.h),
                            const Text('Image not found'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Author: ${siteModel.author}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Contact: ${siteModel.contact}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  siteModel.hashtag,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
