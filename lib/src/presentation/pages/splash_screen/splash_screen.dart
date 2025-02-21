import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/quotes_cubit/cubit/quotes_cubit.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );
    context.read<AnimeInfoCubit>().fetchCategories();
    context.read<QuotesCubit>().fetchQuote();
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.pushReplacementNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoSize = size.width * 0.3; // 30% от ширины экрана
    final loadingSize = size.width * 0.2; // 20% от ширины экрана
    final bloc = BlocProvider.of<AnimeInfoCubit>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  'assets/animations/rem_pat.gif',
                  width: logoSize,
                  height: logoSize,
                ),
              ),
            ),
            BlocListener<AnimeInfoCubit, AnimeInfoState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is AnimeInfoLoaded) {
                  _navigateToHome();
                }
                if (state is AnimeInfoError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                  _navigateToHome();
                }
              },
              child: Container(),
            ),
            SizedBox(height: size.height * 0.03), // 3% от высоты экрана
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomLoadingCircle(
                size: loadingSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
