{
  lib,
  stdenv,
  fetchFromGitHub,
  gcr_4,
  glib,
  gtk4,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gnome-ssh-askpass4";
  version = "0.0.0";

  src = fetchFromGitHub {
    name = "openssh";
    owner = "openssh";
    repo = "openssh-portable";
    rev = "5b0d9e3ed8fd407936d973990ae169cc296150f7";
    hash = "sha256-QJilKQ6weWZuf3L8yUplXwjqlzH5Ki7YeDnCh4HSuIQ=";
  };

  sourceRoot = "openssh/contrib";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    gcr_4
    glib
    gtk4
  ];

  strictDeps = true;

  buildPhase = ''make gnome-ssh-askpass4'';

  installPhase = ''install -Dm 755 gnome-ssh-askpass4 $out/bin/gnome-ssh-askpass4'';

  meta = with lib; {
    description = "A simple SSH passphrase grabber for GNOME";
    homepage = "https://github.com/openssh/openssh-portable";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ];
    mainProgram = "gnome-ssh-askpass4";
  };
})
