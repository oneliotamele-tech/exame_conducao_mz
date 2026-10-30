import 'package:flutter/material.dart';
import 'dart:math';
import 'teoria_data.dart';

void main() {
  runApp(const CartaMzApp());
}

class CartaMzApp extends StatelessWidget {
  const CartaMzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exame de Condução MZ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exame de Condução MZ'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: todosOsExames.length,
        itemBuilder: (context, index) {
          final exame = todosOsExames[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.assignment, color: Colors.blue),
              title: Text(exame.titulo),
              subtitle: Text('${exame.numeroPerguntas} perguntas'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(exame: exame),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final Exame exame;

  const QuizPage({super.key, required this.exame});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Pergunta> _perguntasSorteadas;
  int _indiceAtual = 0;
  int? _opcaoEscolhida;
  int _acertos = 0;

  @override
  void initState() {
    super.initState();
    _gerarExame();
  }

  void _gerarExame() {
    // MODO DE TESTE: Sem sorteio. Ele pega as perguntas na ordem exata.
    final quantidade = min(widget.exame.numeroPerguntas, bancoDePerguntas.length);
    
    setState(() {
      _perguntasSorteadas = bancoDePerguntas.take(quantidade).toList();
      _indiceAtual = 0;
      _opcaoEscolhida = null;
      _acertos = 0;
    });
  }

  void _responder(int indice) {
    if (_opcaoEscolhida != null) return;

    setState(() {
      _opcaoEscolhida = indice;
      if (indice == _perguntasSorteadas[_indiceAtual].indiceCorreto) {
        _acertos++;
      }
    });
  }

  void _proxima() {
    setState(() {
      if (_indiceAtual < _perguntasSorteadas.length - 1) {
        _indiceAtual++;
        _opcaoEscolhida = null;
      } else {
        _mostrarResultado();
      }
    });
  }

  void _mostrarResultado() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Resultado'),
        content: Text('Acertaste $_acertos de ${_perguntasSorteadas.length} perguntas.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o dialog
              _gerarExame(); // Reinicia o quiz
            },
            child: const Text('Tentar novamente'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o dialog
              Navigator.pop(context); // Volta para o menu de exames
            },
            child: const Text('Voltar aos exames'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_perguntasSorteadas.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.exame.titulo)),
        body: const Center(child: Text('Não há perguntas suficientes no banco.')),
      );
    }

    final pergunta = _perguntasSorteadas[_indiceAtual];
    final respondida = _opcaoEscolhida != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exame.titulo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (_indiceAtual + 1) / _perguntasSorteadas.length,
              ),
              const SizedBox(height: 8),
              Text(
                'Pergunta ${_indiceAtual + 1} de ${_perguntasSorteadas.length}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                pergunta.enunciado,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              
              // BLOCO DE EXIBIÇÃO DA IMAGEM
              if (pergunta.imagemAsset != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    pergunta.imagemAsset!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        color: Colors.grey.shade300,
                        child: const Center(child: Text('Imagem não encontrada')),
                      );
                    },
                  ),
                ),
              ],
              
              const SizedBox(height: 20),
              ...List.generate(pergunta.opcoes.length, (i) {
                Color? corFundo;
                if (respondida) {
                  if (i == pergunta.indiceCorreto) {
                    corFundo = Colors.green.shade200;
                  } else if (i == _opcaoEscolhida) {
                    corFundo = Colors.red.shade200;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: corFundo,
                    child: ListTile(
                      title: Text(pergunta.opcoes[i]),
                      onTap: respondida ? null : () => _responder(i),
                    ),
                  ),
                );
              }),
              if (respondida) ...[
                const SizedBox(height: 16),
                Text(
                  pergunta.explicacao,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _proxima,
                  child: Text(
                    _indiceAtual < _perguntasSorteadas.length - 1
                        ? 'Próxima pergunta'
                        : 'Ver resultado',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}