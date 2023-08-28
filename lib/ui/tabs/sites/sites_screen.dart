import 'package:cached_network_image/cached_network_image.dart';
import 'package:columnist/cubits/sites/sites_cubit.dart';
import 'package:columnist/cubits/sites/sites_state.dart';
import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/ui/tabs/sites/site_detail/site_detail_screen.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
        () => BlocProvider.of<SiteCubit>(context).getSites(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Center(
          child: SvgPicture.asset(AppIcons.smallLogo),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: BlocConsumer<SiteCubit, SiteState>(
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(
                state.sites.length,
                (index) {
                  SiteModel site = state.sites[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SiteDetailScreen(id: site.id),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                site.author,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.16.sp,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                site.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.16.sp,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey,
                                  ),
                                  height: 300.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: CachedNetworkImage(
                                    imageUrl: baseUrl + site.image.substring(1),
                                    fit: BoxFit.fill,
                                    errorWidget: (e1, e2, e3) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey,
                                      ),
                                      height: 250.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error,
                                            size: 100.h,
                                          ),
                                          const Text('Image not found'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                site.hashtag,
                                style: TextStyle(
                                  color: Colors.blue,
                                  letterSpacing: 0.16.sp,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Uri url = Uri.parse(site.link);
                                      launchUrl(url);
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width-60.w,
                                      child: Text(
                                        site.link,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          letterSpacing: 0.16.sp,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer()
                                 ,const LikeButton(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xFF616161),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            Center(
              child: Text(
                state.statusText,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
