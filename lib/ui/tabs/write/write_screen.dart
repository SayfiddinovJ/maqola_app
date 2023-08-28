import 'package:columnist/ui/tabs/home/article_add/article_add_screen.dart';
import 'package:columnist/ui/tabs/sites/site_add/site_add_screen.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SiteAddScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 27.h),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Add Site',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.16.sp,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ArticleAddScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 27.h),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Add Article',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.16.sp,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
