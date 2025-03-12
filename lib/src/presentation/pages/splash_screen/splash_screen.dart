import 'package:restful_solid_bloc/src/presentation/pages/home_page/home_page_imports.dart';
import 'splash_screen_imports.dart';

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
      duration: const Duration(seconds: 1),
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
    final bloc = context.read<AnimeInfoCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/background/splashBG5.jpg',
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment(
                    0.4,
                    -0.2,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: size.width * 0.6,
                height: size.height,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(
                    100,
                  ),
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'H O R N E T',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                            shadows: [
                              Shadow(
                                color: AppColors.secondaryGray,
                                offset: const Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                            color: AppColors.primaryWhite,
                          ),
                        ),
                        Text(
                          'let\'s all love Rem',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                            shadows: [
                              Shadow(
                                color: AppColors.primaryBlack,
                                offset: const Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
        ],
      ),
    );
  }
}
