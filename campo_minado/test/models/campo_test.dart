import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir Campo COM Explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.minar();
      expect(campo.abrir, throwsException);
    });

    test('Abrir Campo SEM Explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.abrir();
      expect(campo.aberto, isTrue);
    });

    test('Adicionar NÃO Vizinho', () {
      Campo campo1 = Campo(linha: 0, coluna: 0);
      Campo campo2 = Campo(linha: 1, coluna: 3);
      campo1.adicionarVizinho(campo2);
      expect(campo1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar Vizinho', () {
      Campo campo1 = Campo(linha: 3, coluna: 3);
      Campo campo2 = Campo(linha: 3, coluna: 4);
      Campo campo3 = Campo(linha: 2, coluna: 2);
      Campo campo4 = Campo(linha: 4, coluna: 4);
      campo1.adicionarVizinho(campo2);
      campo1.adicionarVizinho(campo3);
      campo1.adicionarVizinho(campo4);
      expect(campo1.vizinhos.length, 3);
    });

    test('Minas na Vizinhança', () {
      Campo campo1 = Campo(linha: 3, coluna: 3);
      Campo campo2 = Campo(linha: 3, coluna: 4);
      campo2.minar();
      Campo campo3 = Campo(linha: 2, coluna: 2);
      Campo campo4 = Campo(linha: 4, coluna: 4);
      campo4.minar();
      campo1.adicionarVizinho(campo2);
      campo1.adicionarVizinho(campo3);
      campo1.adicionarVizinho(campo4);
      expect(campo1.qtdeMinasNaVizinhanca, 2);
    });
  });
}
