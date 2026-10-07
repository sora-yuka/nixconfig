{
  description = "Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };

        android = pkgs.androidenv.composeAndroidPackages {
          platformVersions = [ "35" "36" ];
          buildToolsVersions = [ "35.0.0" "36.0.0" ];
          includeEmulator = true;
          includeSystemImages = true;
          systemImageTypes = [ "google_apis" ];
          abiVersions = [ "x86_64" ];
          includeNDK = true;
          ndkVersions = [ "28.2.13676358" ];
          cmakeVersions = [ "3.22.1" ];
        };
        sdk = "${android.androidsdk}/libexec/android-sdk";
      in {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.flutter android.androidsdk pkgs.jdk17 ];

          ANDROID_HOME = sdk;
          ANDROID_SDK_ROOT = sdk;
          JAVA_HOME = pkgs.jdk17.home;
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${sdk}/build-tools/35.0.0/aapt2";
        };
      });
}
