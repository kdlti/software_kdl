import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:teste_git_hub/ui/picking_list/ui/page_presenter.dart';
import 'custom_data.dart';
import 'examples.dart';
import 'package:pdf/widgets.dart' as pw;

class MyAppPdf extends StatefulWidget {
  final PagePresenter presenter;
  const MyAppPdf({Key? key, required this.presenter}) : super(key: key);

  @override
  MyAppPdfState createState() {
    return MyAppPdfState();
  }
}

class MyAppPdfState extends State<MyAppPdf>
    with SingleTickerProviderStateMixin {
  int _tab = 0;
  TabController? _tabController;
  bool _isLoading = false;
  String _loadingMessage = "Gerando PDF...";
  int _elapsedSeconds = 0;
  Timer? _timer;

  PrintingInfo? printingInfo;

  var _data = const CustomData();
  var _hasData = false;
  var _pending = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    _takePdfFile(
      context,
      (format) => examples[_tab].builder(
        format,
        _data,
        widget.presenter.simucEntity,
        widget.presenter.costumer,
        widget.presenter.box,
        widget.presenter.receiveArId,
        widget.presenter.receiveArDoc,
        widget.presenter.quantityInvoice,
        tipoRomaneio: _getTipoRomaneio(),
      ),
      PdfPageFormat.a4,
    );
    _tabController = TabController(
      vsync: this,
      length: examples.length,
      initialIndex: _tab,
    );
    _tabController!.addListener(
      () {
        if (_tab != _tabController!.index) {
          setState(() {
            _tab = _tabController!.index;
          });
        }
        if (examples[_tab].needsData && !_hasData && !_pending) {
          _pending = true;
          askName(context).then((value) {
            if (value != null) {
              setState(() {
                _data = CustomData(name: value);
                _hasData = true;
                _pending = false;
              });
            }
          });
        }
      },
    );

    setState(() {
      printingInfo = info;
    });
  }

  // void _showPrintedToast(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Documento impresso com sucesso'),
  //     ),
  //   );
  // }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document baixado com sucesso'),
      ),
    );
  }

  Future<Uint8List> _getPdfBytes(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    return await build(pageFormat);
  }

  Future<void> _takePdfFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    try {
      setState(() {
        _isLoading = true;
        _loadingMessage = "Gerando PDF...";
        _elapsedSeconds = 0;
      });
      
      // Iniciar o timer para contar o tempo decorrido
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedSeconds++;
        });
      });
      
      print('Iniciando geração do PDF para o romaneio...');
      final bytes = await _getPdfBytes(context, build, pageFormat);
      print('PDF gerado com sucesso, tamanho: ${bytes.length} bytes');
      
      setState(() {
        _loadingMessage = "Enviando dados...";
      });
      
      print('Enviando bytes para o presenter...');
      await widget.presenter.printBytes(bytes);
      
      setState(() {
        _loadingMessage = "Salvando romaneio...";
      });
      
      print('Iniciando processo de salvar romaneio...');
      await widget.presenter.savePackingList();
      print('Romaneio salvo com sucesso!');
      
      _timer?.cancel();
      setState(() {
        _isLoading = false;
        _elapsedSeconds = 0;
      });
      
      // Mostrar uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Romaneio criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      _timer?.cancel();
      setState(() {
        _isLoading = false;
        _elapsedSeconds = 0;
      });
      
      print('Erro ao gerar PDF ou salvar picking list: $e');
      // Mostrar erro ao usuário de forma mais detalhada
      String errorMessage = 'Erro ao salvar romaneio';
      
      if (e.toString().contains('WebSocket')) {
        errorMessage = 'Erro de conexão. Verifique sua conexão com a internet e tente novamente.';
      } else if (e.toString().contains('bytes')) {
        errorMessage = 'Erro ao gerar o PDF. Tente novamente.';
      } else if (e.toString().contains('Timeout')) {
        errorMessage = 'A operação demorou muito tempo. Verifique sua conexão e tente novamente.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  // Função para formatar o tempo decorrido
  String _formatElapsedTime() {
    final minutes = _elapsedSeconds ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    if (_tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return WillPopScope(
      onWillPop: () async {
        if (_isLoading) {
          // Mostrar diálogo de confirmação se estiver carregando
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Atenção!'),
                content: const Text(
                    'O romaneio ainda está sendo criado. Se você sair agora, o processo será interrompido e o romaneio não será salvo. Deseja realmente sair?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Não permite sair
                    },
                    child: const Text('Não, continuar criando'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Permite sair
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Sim, sair mesmo assim'),
                  ),
                ],
              );
            },
          );
          return shouldPop ?? false;
        }
        return true; // Se não estiver carregando, permite sair normalmente
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('PDF'),
              // bottom: TabBar(
              //   controller: _tabController,
              //   tabs: examples.map<Tab>((e) => Tab(text: e.name)).toList(),
              //   isScrollable: true,
              // ),
            ),
            body: PdfPreview(
              pdfFileName: "Romaneio_${DateFormat('dd-MM-yyyy_HH-mm').format(DateTime.now())}.pdf",
              allowPrinting: false,
              canDebug: false,
              canChangePageFormat: false,
              canChangeOrientation: false,
              maxPageWidth: 800,
              build: (format) => examples[_tab].builder(
                format,
                _data,
                widget.presenter.simucEntity,
                widget.presenter.costumer,
                widget.presenter.box,
                widget.presenter.receiveArId,
                widget.presenter.receiveArDoc,
                widget.presenter.quantityInvoice,
                tipoRomaneio: _getTipoRomaneio(),
              ),
              // onPrinted: _showPrintedToast,
              onShared: _showSharedToast,
            ),
          ),
          // Overlay de loading
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade700,
                            strokeWidth: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _loadingMessage,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.blue.shade800,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                "Não feche esta janela até a conclusão",
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_loadingMessage.contains("Salvando"))
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.grey.shade800,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "Isso pode levar alguns segundos...",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.blue.shade500,
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

  Future<String?> askName(BuildContext context) {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final controller = TextEditingController();

          return AlertDialog(
            title: const Text('Please type your name:'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: TextField(
              decoration: const InputDecoration(hintText: '[your name]'),
              controller: controller,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.text != '') {
                    Navigator.pop(context, controller.text);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  // Método auxiliar para obter o tipo de romaneio
  String _getTipoRomaneio() {
    try {
      // Adicionar um método getter para o tipo de romaneio no PagePresenter
      final presenter = widget.presenter;
      // Apenas um fallback tentando acessar a variável privada diretamente
      if (presenter is dynamic) {
        try {
          dynamic value = presenter.tipoRomaneio;
          if (value is String) {
            return value;
          }
        } catch(_) {}
      }
    } catch (e) {
      print('Erro ao obter tipo de romaneio: $e');
    }
    return 'normal';
  }
}
