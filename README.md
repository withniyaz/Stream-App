COMP-1252-M03-2022-23 MSc Project

#Steps to run the project

1. Need to download Flutter SDK 3.3.10, Please download the SDK based on the OS from links below

   Flutter SDK macOS(x64) - https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.3.10-stable.zip
   Flutter SDK macOS(arm) - https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.3.10-stable.zip
   Flutter SDK Windows(x64) - https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.3.10-stable.zip

2. Follow the steps to install the SDK based on the OS from the links below

   Flutter SDK Installation Documentation Windows - https://docs.flutter.dev/get-started/install/windows
   Flutter SDK Installation Documentation macOS - https://docs.flutter.dev/get-started/install/macos

3. Once the SDK is setup the project can be runned using any Code Editors like VS Code or Android Studio, Links are given below as per needs

   Android Studio macOS(x64) - https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac.dmg
   Android Studio macOS(arm) - https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac_arm.dmg
   Android Studio Windows - https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-windows.exe

   VS Code macOS(Universal) - https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal
   VS Code Windows - https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user

4. Open the project in the desired code editor
5. Get all packages needed for the project by running "flutter pub get" (In android studio it is runned automatically)
6. Open any simulator, either an android emulator or ios simulator.
7. The backend server is currently hosted in a Google Cloud VM, if your planning to test application locally. The Backend Node.JS project is available in the respective zip folder.
8. The app can be runned locally or via VM. you can change the API end-point url to the backend server on lib/constants/app_constants.dart and uncomment
   local end-point if your planning to run the application locally or keep in the default VM end-point.
9. If your planning to run locally please change the API end-point to local system IP Address.
10. To run the project type in "flutter run" and select simulator device.

Project Flutter Version 3.3.10
University of Greenwich.
