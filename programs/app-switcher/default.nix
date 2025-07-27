{ stdenv }:

stdenv.mkDerivation rec {
  pname = "app-switcher";
  version = "0.1.0";

  src = ./.;

  buildPhase = ''
    runHook preBuild

    $CXX -std=c++17 -O2 -o ${pname} src/main.cpp

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ${pname} $out/bin/

    runHook postInstall
  '';

  meta.description = "Sets focus to the specified app using Aerospace and the open command";
}
