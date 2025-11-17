{
  pkgs,
  ...
}:
{

  programs.zellij = {
    enable = true;
    extraConfig = builtins.readFile ./zellij.config.kdl;
    layouts = {
      devel = ./zellij.layout.devel.kdl;
      zsm = ./zellij.layout.zsm.kdl;
    };
  };

  home.file.".config/zellij/plugins/zsm.wasm".source = pkgs.fetchurl {
    url = "https://github.com/liam-mackie/zsm/releases/download/v0.4.1/zsm.wasm";
    sha256 = "sha256-+VCf9MEHQVmr2q8lu95jAOsvCQU0iJa3ljqbnIC9ywg=";
  };

  home.file.".config/zellij/plugins/forgot.wasm".source = pkgs.fetchurl {
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.2/zellij_forgot.wasm";
    sha256 = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
  };
}
