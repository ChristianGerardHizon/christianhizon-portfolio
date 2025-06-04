# sannjosevet

A new Flutter project.

## Getting Started


### Build packages
`dart pub get ;dart run build_runner build --delete-conflicting-outputs`
`dart run slang`
`dart run change_app_package_name:main com.it2do.dev`

### Generate ymal icon file
1. `dart run flutter_launcher_icons:generate`
2. `dart run flutter_launcher_icons`


### Change package name
`dart run package_rename`

# pocketbase
`pocketbase admin create admin@test.com password101`

`pocketbase serve --dir .`

# Deploy Sever to flycytl

`flyctl launch --build-only --dockerfile`

# Deploy Staging Site

surge --domain stg-sannjose.surge.sh build/web

# update splash screen

dart run flutter_native_splash:create
