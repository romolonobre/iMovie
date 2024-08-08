import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../app_services/utils.dart';
import '../../imovie_ui/iui_loader.dart';
import '../../imovie_ui/iui_text.dart';
import 'seach_result.dart';
import 'search_controller.dart';
import 'search_state.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // Link for positioning the overlay
  final layerLink = LayerLink();
  final controller = CustomSearchController();
  final SpeechToText voiceToText = SpeechToText();
  final TextEditingController textEditingController = TextEditingController();
  bool isListening = false;
  OverlayEntry? entry;
  Timer? debounce;
  String words = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
        child: TextFormField(
          controller: textEditingController,
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            _onSearchChanged(value);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: 'Search',
            filled: true,
            fillColor: Colors.white12,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.white60, fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: Colors.white60),
            suffixIcon: InkWell(
              onTap: () {
                if (voiceToText.isNotListening) {
                  _startListening();
                  return;
                }

                _stopListening();
              },
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(width: 1, color: Colors.white24),
                    ),
                    AvatarGlow(
                      glowColor: Colors.red,
                      animate: isListening,
                      glowRadiusFactor: 20,
                      child: Icon(
                        isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.white60,
                      ).paddingOnly(left: 15, right: 15, top: 5, bottom: 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ).borderRadius(10),
    );
  }

// Shows the overlay with search results
  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // Remove any existing overlay before creating a new one
    entry?.remove();
    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 10),
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, state, __) {
              return switch (state) {
                SearchIdleState() => const SizedBox.shrink(),
                SearchLoadingState() => const IUILoader(),
                SearchErrorState state => _onErrorContainer(state.errorMessage),
                SearchLoadedState state =>
                  state.result.isEmpty ? _noResultsContainer() : _resultsContainer(state.result),
              };
            },
          ),
        ),
      ),
    );
    overlay.insert(entry!);
  }

  // Handle input changes with debounce
  void _onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 400), () {
      if (value.length > 4) {
        controller.search(value).then((_) => _showOverlay());
      } else {
        _hideOverlay();
      }
    });
  }

  // Hides the overlay
  void _hideOverlay() {
    entry?.remove();
    entry = null;
  }

  // Widget to show when there are no search results
  Widget _noResultsContainer() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor.withOpacity(0.9),
        child: IUIText.heading("No movies found", color: Colors.white),
      ),
    );
  }

  // Widget to show when there is an error in the search
  Widget _onErrorContainer(String errorMessage) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor.withOpacity(0.9),
        child: IUIText.heading(errorMessage, color: Colors.red),
      ),
    );
  }

  // Widget to show the search results
  Widget _resultsContainer(List<SearchResult> results) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 450),
        color: backgroundColor.withOpacity(0.9),
        child: SingleChildScrollView(
          child: Column(
            children: results.map(
              (result) {
                return ListTile(
                  title: IUIText.heading(result.title, color: Colors.white),
                  leading: Image.network(
                    result.postPath,
                    height: 80,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 80,
                      width: 100,
                      decoration: const BoxDecoration(color: backgroundColor),
                    ),
                  ).borderRadius(8),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                ).paddingOnly(top: 15);
              },
            ).toList(),
          ),
        ).paddingAll(15),
      ),
    );
  }

  // Init
  void _initSpeech() async {
    await voiceToText.initialize();

    setState(() {});
  }

  // Start listening to voice
  void _startListening() async {
    words = '';
    await voiceToText.listen(onResult: _onSpeechResult);
    isListening = true;
    setState(() {});
  }

  // Stop listening voice and search
  void _stopListening() async {
    await voiceToText.stop();
    isListening = false;
    _onSearchChanged(words);
    setState(() {});
  }

// Handle voice recognition results
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      words = result.recognizedWords;
      textEditingController.text = words;

      // Move cursor to the end
      textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length),
      );
    });
  }
}
