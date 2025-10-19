{
  pkgs,
  ...
}:
{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    ignores = [
      "!.jj"
    ];
    settings = {
      theme = "ayu_dark";
      editor = {
        auto-pairs = false;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        cursorline = true;
        true-color = true;
        undercurl = true;
      };
    };
  };
}
