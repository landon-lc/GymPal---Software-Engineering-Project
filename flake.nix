# For Michael's dev environment :)
{
description = "Flutter 3.13.x";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/23.11";
  flake-utils.url = "github:numtide/flake-utils";
  flutter-nix.url = "github:maximoffua/flutter.nix";
};
outputs = { self, nixpkgs, flake-utils, flutter-nix }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          flutter-nix.overlays.default
        ];
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        cmdLineToolsVersion = "9.0";
        toolsVersion = "26.1.1";
        platformToolsVersion = "34.0.5";
        buildToolsVersions = [ "30.0.3" ];
        includeEmulator = false;
        emulatorVersion = "34.1.9";
        platformVersions = [ "34" "33" ];
        includeSources = false;
        includeSystemImages = false;
        systemImageTypes = [ "google_apis_playstore" ];
        abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
        cmakeVersions = [ "3.10.2" ];
        includeNDK = true;
        ndkVersions = ["22.0.7026061"];
        useGoogleAPIs = false;
        useGoogleTVAddOns = false;
        includeExtras = [
          "extras;google;gcm"
        ];
      };
    in
    {
      pkgs.flutter = flutter-nix.packages.${system}.flutter;
      devShell =
        with pkgs; mkShell rec {
          ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
          buildInputs = [
            flutter
            androidComposition.androidsdk
            jdk17
          ];
	  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/30.0.3/aapt2";
        };
    });
}
