import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/managers/cubit/tracker.dart';
import 'package:flutter_pro/tracker_app/widgets/arrow_widget.dart';
import 'package:flutter_pro/tracker_app/widgets/person_tacker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackerAppBody extends StatelessWidget {
  const TrackerAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackerCubit(),
      child: BlocBuilder<TrackerCubit, TrackerState>(
        builder: (context, state) {
          final bool isArrowsActive =
              state is TrackerUpdated && state.persons.length > 1;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: context.read<TrackerCubit>().fieldText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.05),
                    hintText: 'Enter the name for a person to track',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.person_add_rounded,
                      color: Colors.blue,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (String value) {
                    context.read<TrackerCubit>().addPerson(value);
                    log('Name added: $value');
                    context.read<TrackerCubit>().fieldText.clear();
                  },
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ArrowWidget(
                    isArrowsActive: isArrowsActive,
                    onTap: () => context.read<TrackerCubit>().previousPerson(),
                    isLeftArrow: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 180,
                      width: 240,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 300,
                          ), 
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                          child: switch (state) {
                            TrackerEmpty() => const Text(
                              'No persons to track yet!\nAdd someone above.',
                              key: ValueKey('empty'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TrackerAddLoading() =>
                              const CircularProgressIndicator(
                                key: ValueKey('loading'),
                                strokeWidth: 3,
                              ),
                            TrackerUpdated() => () {
                              final currentEntry = state.persons.entries
                                  .elementAt(state.currentIndex);
                              return PersonTracker(
                                key: ValueKey(currentEntry.key),
                                name: currentEntry.key,
                                score: currentEntry.value,
                              );
                            }(),
                          },
                        ),
                      ),
                    ),
                  ),
                  ArrowWidget(
                    isArrowsActive: isArrowsActive,
                    onTap: () => context.read<TrackerCubit>().nextPerson(),
                    isLeftArrow: false,
                  ),
                ],
              ),
            
            ],
          );
        },
      ),
    );
  }
}



  // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ArrowWidget(
              //       isArrowsActive: isArrowsActive,
              //       onTap: () => context.read<TrackerCubit>().previousPerson(),
              //       isLeftArrow: true,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 20),
              //       child: SizedBox(
              //         height: 150,
              //         child: Center(
              //           child: switch (state) {
              //             TrackerEmpty() => const Text(
              //               'No persons to track yet!\nAdd someone above.',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(color: Colors.grey, fontSize: 16),
              //             ),
              //             TrackerAddLoading() =>
              //               const CircularProgressIndicator(),
              //             TrackerUpdated() => IndexedStack(
              //               index: state.currentIndex,
              //               children: <Widget>[
              //                 for (var entry in state.persons.entries)
              //                   PersonTracker(
              //                     name: entry.key,
              //                     score: entry.value,
              //                   ),
              //               ],
              //             ),
              //           },
              //         ),
              //       ),
              //     ),
              //     ArrowWidget(
              //       isArrowsActive: isArrowsActive,
              //       onTap: () => context.read<TrackerCubit>().nextPerson(),
              //       isLeftArrow: false,
              //     ),
              //   ],
              // ),