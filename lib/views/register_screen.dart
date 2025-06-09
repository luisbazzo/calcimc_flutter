import 'package:flutter/material.dart';
import 'package:flutter_calcimc_prova2/database/database.dart';
import 'package:flutter_calcimc_prova2/styles/app_styles.dart';
import 'package:flutter_calcimc_prova2/views/login_screen.dart';

class RegisterScreen extends StatefulWidget 
{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> 
{
  final keyForm = GlobalKey<FormState>();
  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final databaseHelper = DatabaseHelper();

  void register() async 
  {
    if(keyForm.currentState!.validate()) 
    {
      final existingUser = await databaseHelper.getUser(emailControl.text);
      if(existingUser != null) 
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email já cadastrado!')),
        );
        return;
      }

      await databaseHelper.addUser(nameControl.text, emailControl.text, passwordControl.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cobra Kai IMC',
          style: AppTextStyles.titleCobraKai,
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 11),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppSpacing.logoLeftPadding, AppSpacing.logoTopPadding, AppSpacing.logoRightPadding, AppSpacing.logoBottomPadding),
              child: Image.asset(
                "assets/images/logo.png",
                width: 250,
                height: 250,
              ),
            ),
          ),
          Expanded(child:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameControl,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu nome!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailControl,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu email!';
                        } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$')
                            .hasMatch(value)) {
                          return 'Email inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordControl,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite sua senha!';
                        } else if (value.length < 8) {
                          return 'A senha deve ter pelo menos 8 caracteres, com pelo menos um número e uma letra!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: register,
                      style: AppTextStyles.roundedButton(AppColors.red),
                      child: const Text('Cadastrar', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ), 
          ),
        ],
      ),
    );
  }
}