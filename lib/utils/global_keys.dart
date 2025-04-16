import 'package:flutter/material.dart';

// Instead of static GlobalKeys, use factory functions to create new keys when needed
GlobalKey<State> createLoadingKey() => GlobalKey<State>();

GlobalKey<State> createLoadingVerifiedKey() => GlobalKey<State>();
