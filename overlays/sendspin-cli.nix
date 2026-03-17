final: prev:

let
  py = prev.python313Packages;

  aiosendspin = py.buildPythonPackage {
    pname = "aiosendspin";
    version = "4.3.4";

    src = prev.fetchFromGitHub {
      owner = "Sendspin";
      repo = "aiosendspin";
      rev = "main";
      sha256 = "sha256-RDoNEov9OgZGYRrhDQ/VUMin18mJRIZTxXIb5xMxYcQ=";
    };

    doCheck = false;

    pyproject = true;
    build-system = with py; [
      setuptools
      wheel
    ];
    propagatedBuildInputs = with py; [
      aiohttp
      av
      mashumaro
      orjson
      pillow
      zeroconf
    ];
  };

  mpris-api = py.buildPythonPackage {
    pname = " mpris-api";
    version = "2.1.0";

    src = prev.fetchFromBitbucket {
      owner = "massultidev";
      repo = "mpris-api";
      rev = "master";
      sha256 = "sha256-MzeJIPPZkOQSsytNaETRZC9WwQflYzcL4TG705N7pEg=";
    };

    doCheck = false;

    pyproject = true;
    build-system = with py; [
      setuptools
      wheel
    ];
    propagatedBuildInputs = [
      # py.aiohttp
      py.av
      # py.mashumaro
      # py.orjson
      # py.pillow
      # py.zeroconf
      # # py.mpris-api
      # aiosendspin
    ];

    # dontCheckRuntimeDeps = true;
  };

  aiosendspin-mpris = py.buildPythonPackage {
    pname = " aiosendspin-mpris";
    version = "2.1.1";

    src = prev.fetchFromGitHub {
      owner = "abmantis";
      repo = "aiosendspin-mpris";
      rev = "main";
      sha256 = "sha256-hOF6rTm0pppk+J7tTVaLDK5C1ofGXz1YU6RVGm92geQ=";
    };

    # do not run tests
    doCheck = false;

    # specific to buildPythonPackage, see its reference
    pyproject = true;
    build-system = with py; [
      setuptools
      wheel
    ];
    propagatedBuildInputs = [
      py.aiohttp
      py.av
      py.mashumaro
      py.orjson
      py.pillow
      py.zeroconf
      # py.mpris-api
      aiosendspin
    ];

    dontCheckRuntimeDeps = true;
  };

in
{
  sendspin-cli = py.buildPythonApplication {
    pname = "sendspin-cli";
    version = "5.5.1";

    src = prev.fetchFromGitHub {
      owner = "Sendspin";
      repo = "sendspin-cli";
      rev = "main";
      sha256 = "sha256-yq4TTSm2y+oSKT63aM/01gsZRjZShfe3UA9yuv3dOvc=";
    };

    pyproject = true;
    nativeBuildInputs = with py; [
      setuptools
      wheel
    ];

    # ✅ explicitly reference the already-built aiosendspin
    propagatedBuildInputs = [
      py.aioconsole
      aiosendspin-mpris
      py.sounddevice
      aiosendspin
      py.qrcode
      py.readchar
      py.rich
    ];

    buildInputs = [ prev.portaudio ];

    dontCheckRuntimeDeps = true;
  };
}
