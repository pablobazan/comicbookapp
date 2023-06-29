import 'package:animate_do/animate_do.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/home/presentation/widgets/loading_fade_in_up/bloc/loading_fade_in_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoadingFadeInUp extends StatefulWidget {
  const LoadingFadeInUp({Key? key}) : super(key: key);

  @override
  State<LoadingFadeInUp> createState() => _LoadingFadeInUpState();
}

class _LoadingFadeInUpState extends State<LoadingFadeInUp> {
  late AnimationController _animationLoadingController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadingFadeInUpBloc, LoadingFadeInUpState>(
      listener: (context, state) {
        if (state is LoadingFadeInUpLoading) {
          playAnimation();
        }
      },
      builder: (context, state) {
        return FadeInUp(
          duration: const Duration(milliseconds: 300),
          animate: false,
          manualTrigger: true,
          controller: (animationController) =>
              _animationLoadingController = animationController,
          child: Offstage(
              offstage: !state.isShowing,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: const CircularProgressIndicator(
                      color: AppColors.black, backgroundColor: Colors.blueGrey),
                ),
              )),
        );
      },
    );
  }

  void playAnimation() {
    if (_animationLoadingController.isCompleted) {
      _animationLoadingController.reset();
    }
    _animationLoadingController.forward();
  }
}
