import 'package:fluent_ui/fluent_ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Carregando...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ProgressRing(
              activeColor: Color.fromARGB(255, 255, 128, 25),
            ),
          ],
        ),
      ),
    );
  }
}
