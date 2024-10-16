// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const Calculadora());
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}
class _CalculadoraState extends State<Calculadora> {
  String display = ""; // Armazena o valor atual no display.
  String operacaoAtual = ""; // Armazena a operação atual.
  double primeiroNumero = 0.0; // Primeiro número inserido pelo usuário.

  // Função que realiza as operações de cálculo e lida com a lógica de exibição.
  void calcular(String tecla) {
    setState(() {
      switch (tecla) {
        case "C": // Limpa o display e reseta os estados.
          display = "";
          operacaoAtual = "";
          primeiroNumero = 0.0;
          break;

        case "<X": // Apaga o último caractere.
          if (display.isNotEmpty) {
            display = display.substring(0, display.length - 1);
          }
          break;

        case "=": // Realiza a operação e exibe o resultado.
          double resultado = 0.0;
          double segundoNumero = double.parse(display.replaceAll(",", "."));

          switch (operacaoAtual) {
            case "/":
              if (segundoNumero == 0) {
                // Exibe "ERRO" ao tentar dividir por zero.
                display = "ERRO";
                return;
              }
              resultado = primeiroNumero / segundoNumero;
              break;

            case "X":
              // Multiplicação por zero sempre retorna 0.
              resultado = primeiroNumero * segundoNumero;
              break;

            case "+":
              resultado = primeiroNumero + segundoNumero;
              break;

            case "-":
              resultado = primeiroNumero - segundoNumero;
              break;

            case "%":
              resultado = primeiroNumero / 100;
              break;
          }

          // Verifica se o resultado é um número inteiro.
          String resultadoString = resultado.toString();
          List<String> partes = resultadoString.split('.');

          if (int.parse(partes[1]) == 0) {
            display = resultado.toInt().toString(); // Exibe apenas a parte inteira.
          } else {
            display = resultadoString.replaceAll('.', ','); // Exibe o número com vírgula.
          }
          break;

        case "/":
        case "X":
        case "-":
        case "+":
        case "%":
          // Armazena o primeiro número e a operação.
          primeiroNumero = double.parse(display.replaceAll(",", "."));
          operacaoAtual = tecla;
          display = ""; // Limpa o display para o próximo número.
          break;

        default: // Adiciona números e vírgulas ao display.
          if (display == "ERRO") display = ""; // Limpa o erro.
          display += tecla;
      }
    });
  }

  // Função para criar botões personalizados.
  Widget buildButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey[300],
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Calculadora")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  operacaoAtual,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  display,
                  style: const TextStyle(fontSize: 60),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/images/historia.png", scale: 12),
                  Image.asset("assets/images/medir.png", scale: 7),
                  Image.asset("assets/images/calculadora-cientifica.png", scale: 8),
                  InkWell(
                    onTap: () => calcular("<X"),
                    child: Image.asset("assets/images/backspace.png", scale: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("C", Colors.red, () => calcular("C")),
                  buildButton("()", Colors.grey, () {}),
                  buildButton("%", Colors.grey, () => calcular("%")),
                  buildButton("/", Colors.orange, () => calcular("/")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("7", Colors.grey, () => calcular("7")),
                  buildButton("8", Colors.grey, () => calcular("8")),
                  buildButton("9", Colors.grey, () => calcular("9")),
                  buildButton("X", Colors.orange, () => calcular("X")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("4", Colors.grey, () => calcular("4")),
                  buildButton("5", Colors.grey, () => calcular("5")),
                  buildButton("6", Colors.grey, () => calcular("6")),
                  buildButton("-", Colors.orange, () => calcular("-")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("1", Colors.grey, () => calcular("1")),
                  buildButton("2", Colors.grey, () => calcular("2")),
                  buildButton("3", Colors.grey, () => calcular("3")),
                  buildButton("+", Colors.orange, () => calcular("+")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildButton("+/-", Colors.grey, () {}),
                  buildButton("0", Colors.grey, () => calcular("0")),
                  buildButton(",", Colors.grey, () => calcular(",")),
                  buildButton("=", Colors.blue, () => calcular("=")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}