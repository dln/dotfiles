{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  gzip,
  libgit2,
  openssh,
  zstd,
  installShellFiles,
  nix-update-script,
  testers,
  jujutsu-openssh,
}:

rustPlatform.buildRustPackage rec {
  pname = "jujutsu-openssh";
  version = "0.21.0+pr3191.openssh";

  src = fetchFromGitHub {
    owner = "dln";
    repo = "jj";
    rev = "5eb51bddb5fe3dbc08fd141cf50c62c73a0e1432"; # https://github.com/dln/jj/tree/openssh
    hash = "sha256-sKMq8xgb2oJ3gi3cThdyjeQ0lfNfgkv495LcRo8H+uc=";
  };

  cargoLock.lockFile = ./Cargo.lock;
  cargoLock.outputHashes = {
    "git2-0.19.0" = "sha256-fV8dFChGeDhb20bMyqefpAD5/+raQQ2sMdkEtlA1jaE=";
  };

  cargoBuildFlags = [
    "--bin"
    "jj"
  ]; # don't install the fake editors
  useNextest = false; # nextest is the upstream integration framework, but is problematic for test skipping
  ZSTD_SYS_USE_PKG_CONFIG = "1"; # disable vendored zlib

  nativeBuildInputs = [
    gzip
    installShellFiles
    pkg-config
  ];

  buildInputs = [
    openssl
    zstd
    libgit2
    openssh
  ];

  postInstall = ''
    $out/bin/jj util mangen > ./jj.1
    installManPage ./jj.1

    installShellCompletion --cmd jj \
      --bash <($out/bin/jj util completion bash) \
      --fish <($out/bin/jj util completion fish) \
      --zsh <($out/bin/jj util completion zsh)
  '';

  checkFlags = [
    # signing tests spin up an ssh-agent and do git checkouts
    "--skip=test_ssh_signing"
  ];

  passthru = {
    updateScript = nix-update-script { };
    tests = {
      version = testers.testVersion {
        package = jujutsu-openssh;
        command = "jj --version";
      };
    };
  };

  meta = with lib; {
    description = "Git-compatible DVCS that is both simple and powerful";
    homepage = "https://github.com/martinvonz/jj";
    changelog = "https://github.com/martinvonz/jj/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [
      _0x4A6F
      thoughtpolice
    ];
    mainProgram = "jj";
  };
}
