import 'package:columnist/cubits/article/article_cubit.dart';
import 'package:columnist/cubits/article/article_state.dart';
import 'package:columnist/data/models/articles/article_fields.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/ui/auth/global_text_field.dart';
import 'package:columnist/ui/auth/widgets/global_button.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/ui_utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ArticleAddScreen extends StatefulWidget {
  const ArticleAddScreen({super.key});

  @override
  State<ArticleAddScreen> createState() => _ArticleAddScreenState();
}

class _ArticleAddScreenState extends State<ArticleAddScreen> {
  ImagePicker imagePicker = ImagePicker();

  late ArticleCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ArticleCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text('Article Add Screen'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ArticleCubit, ArticleState>(
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
                    hintText: 'Title',
                    iconData: Icons.account_circle,
                    textInputType: TextInputType.name,
                    onChanged: (v) => context
                        .read<ArticleCubit>()
                        .updateArticleField(
                            field: ArticleField.title, value: v),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (v) => context
                        .read<ArticleCubit>()
                        .updateArticleField(
                            field: ArticleField.description, value: v),
                    maxLines: 5,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      labelText: 'Description',
                      hintText: 'Description',
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                      counterStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
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
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GlobalButton(
                      onPressed: () async {
                        if (bloc.state.canAddArticle()) {
                          context.read<ArticleCubit>().createArticle();
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
            if (state.status == FormStatus.loading) {
              const Center(child: CircularProgressIndicator());
            }
            if (state.status == FormStatus.success &&
                state.statusText == 'article_added') {
              BlocProvider.of<ArticleCubit>(context).getAllArticles(context);
              showConfirmMessage(
                  title: 'Add', message: 'Article added', context: context);
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
          .read<ArticleCubit>()
          .updateArticleField(field: ArticleField.image, value: xFile.path);
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
          .read<ArticleCubit>()
          .updateArticleField(field: ArticleField.image, value: xFile.path);
    }
  }
}
