{
  stdenvNoCC,
  fetchzip,
}:
let
  version = "0.3.1";
in
stdenvNoCC.mkDerivation {
  name = "lazyjj";
  inherit version;

  src = fetchzip {
    url = "https://github.com/Cretezy/lazyjj/releases/download/v0.3.1/lazyjj-v0.3.1-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-6R4W6uyq8sns8WLoJxp06xAYaJ0Zn+pZLtwhVIPobmc=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 -D $src/lazyjj $out/bin/lazyjj
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/Cretezy/lazyjj";
    description = "TUI for jj";
    mainProgram = "lazyjj";
    platforms = [ "x86_64-linux" ];
  };
}
