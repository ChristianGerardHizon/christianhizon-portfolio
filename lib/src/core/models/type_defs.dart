import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef TaskResult<T> = TaskEither<Failure, T>;

typedef Result<T> = Either<Failure, T>;

typedef MIcons = MdiIcons;
