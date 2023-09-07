import 'package:columnist/cubits/sites/sites_cubit.dart';
import 'package:columnist/cubits/sites/sites_state.dart';
import 'package:columnist/data/models/sites/sites_fields.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/ui/auth/global_text_field.dart';
import 'package:columnist/ui/auth/widgets/global_button.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:columnist/utils/ui_utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SiteAddScreen extends StatefulWidget {
  const SiteAddScreen({super.key});

  @override
  State<SiteAddScreen> createState() => _SiteAddScreenState();
}

class _SiteAddScreenState extends State<SiteAddScreen> {
  ImagePicker imagePicker = ImagePicker();

  late SiteCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SiteCubit>(context);
    super.initState();
  }

  var contactFormatter = MaskTextInputFormatter(
    mask: '+998 (##) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

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
      body: SingleChildScrollView(
        child: BlocConsumer<SiteCubit, SiteState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textFieldBorderColor),
                borderRadius: BorderRadius.circular(18.r),
                color: AppColors.textFieldBackgroundColor,
              ),
              child: Column(
                children: [
                  GlobalTextField(
                    hintText: 'Name',
                    iconData: Icons.account_circle,
                    textInputType: TextInputType.name,
                    onChanged: (v) => context
                        .read<SiteCubit>()
                        .updateSiteField(field: SiteField.name, value: v),
                  ),
                  GlobalTextField(
                    hintText: 'Link',
                    iconData: Icons.link,
                    textInputType: TextInputType.url,
                    onChanged: (v) => context
                        .read<SiteCubit>()
                        .updateSiteField(field: SiteField.link, value: v),
                  ),
                  GlobalTextField(
                    hintText: 'Author',
                    iconData: Icons.edit,
                    textInputType: TextInputType.name,
                    onChanged: (v) => context
                        .read<SiteCubit>()
                        .updateSiteField(field: SiteField.author, value: v),
                  ),
                  GlobalTextField(
                    textInputFormatter: contactFormatter,
                    hintText: 'Contact',
                    iconData: Icons.phone,
                    textInputType: TextInputType.number,
                    onChanged: (v) {
                      v.replaceAll('+', '');
                      v.replaceAll('(', '');
                      v.replaceAll(')', '');
                      v.replaceAll('-', '');
                      v.replaceAll(' ', '');
                      context
                          .read<SiteCubit>()
                          .updateSiteField(field: SiteField.contact, value: v);
                    },
                  ),
                  GlobalTextField(
                    hintText: 'Hashtag',
                    iconData: Icons.numbers,
                    textInputType: TextInputType.name,
                    onChanged: (v) => context
                        .read<SiteCubit>()
                        .updateSiteField(field: SiteField.hashtag, value: v),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Select image',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      showBottomSheetDialog();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GlobalButton(
                      onPressed: () async {
                        if (bloc.state.canAddWebsite()) {
                          context.read<SiteCubit>().createWebsite();
                        }
                      },
                      text: 'ADD',
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state.status == FormStatus.success &&
                state.statusText == 'website_added') {
              BlocProvider.of<SiteCubit>(context).getSites(context);
              showConfirmMessage(
                  title: 'Add', message: 'Site added', context: context);
            }
          },
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: 180.h,
          decoration: BoxDecoration(
            color: AppColors.authBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context
          .read<SiteCubit>()
          .updateSiteField(field: SiteField.image, value: xFile.path);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context
          .read<SiteCubit>()
          .updateSiteField(field: SiteField.image, value: xFile.path);
    }
  }
}
