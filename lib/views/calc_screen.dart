import 'package:flutter/material.dart';
import 'package:flutter_calcimc_prova2/styles/app_styles.dart';

class CalcIMCScreen extends StatefulWidget 
{
  final String name;

  const CalcIMCScreen({super.key, required this.name});

  @override
  State<CalcIMCScreen> createState() => CalcIMCScreenState();

}

class CalcIMCScreenState extends State<CalcIMCScreen> 
{
  final TextEditingController weightControl = TextEditingController();
  final TextEditingController heightControl = TextEditingController();

  String result = "";
  Color resultColor = Color(0xFFFFFFFF);
  String welcomeMsg = "";

  @override
  void initState() {
    super.initState();
    welcomeMessage(); 
  }

  void welcomeMessage()
  {
    final now = DateTime.now();
    final hour = now.hour;

    String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = "Bom dia";
    } else if (hour >= 12 && hour < 18) {
      greeting = "Boa tarde";
    } else {
      greeting = "Boa noite";
    }

    setState(() {
      welcomeMsg = "$greeting, ${widget.name}!";
    });

  }

  void calcIMC() 
  {
    final double? weight = double.tryParse(weightControl.text.replaceAll(',', '.'));
    final double? height = double.tryParse(heightControl.text.replaceAll(',', '.'));

    if (weight != null && weight < 350 && height != null && height > 0 && height < 250) {
      final double imc = weight / ((height/100) * (height/100));
      String classification;

      if(imc < 16) 
      {
        classification = "Magreza grave!";
        resultColor = AppColors.magrezaGrave;
      } else if(imc < 17) {
        classification = "Magreza moderada!";
        resultColor = AppColors.magrezaModerada;
      } else if(imc < 18.5) {
        classification = "Magreza leve!!";
        resultColor = AppColors.magrezaLeve;
      } else if(imc < 25) {
        classification = "Peso ideal!";
        resultColor = AppColors.pesoIdeal;
      } else if(imc < 30) {
        classification = "Sobrepeso!";
        resultColor = AppColors.sobrepeso;
      } else if(imc < 35) {
        classification = "Obesidade grau 1";
        resultColor = AppColors.obesidadeGrau1;
      } else if(imc < 40) {
        classification = "Obesidade grau 2 ou severa!";
        resultColor = AppColors.obesidadeGrau2;
      } else {
        classification = "Obesidade grau 3 ou mórbida!";
        resultColor = AppColors.obesidadeGrau3;
      }

      setState(() {
        result = "IMC: ${imc.toStringAsFixed(2)}\n$classification";
      });
    } else {
      setState(() {
        result = "Valores inválidos!";
      });
    }
    weightControl.clear();
    heightControl.clear();
  }

  void resetFields() {
    weightControl.clear();
    heightControl.clear();
    setState(() {
      result = "";
    });
  }

  void logout(BuildContext context)
  {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // padding opcional para ajustar o posicionamento
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
          ),
        ),
        title: const Text(
          "Cobra Kai IMC",
          style: AppTextStyles.titleCobraKai,
        ),
        backgroundColor: AppColors.black,
        actions: [
          ElevatedButton(
            onPressed: () => logout(context),
            style: AppTextStyles.roundedButtonWithShadow(AppColors.red), 
            child: Text("Logout", style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(welcomeMsg, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.black)),
            const SizedBox(height: 20),
            TextField(
              controller: weightControl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: heightControl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcIMC,
              style: AppTextStyles.roundedButton(AppColors.red),
              child: const Text("Calcular", style: TextStyle(color: AppColors.black)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Informe seus dados!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: resultColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: resultColor),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: resetFields,
              style: AppTextStyles.roundedButton(AppColors.yellow), 
              child: Text("Limpar", style: TextStyle(color: AppColors.black, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
