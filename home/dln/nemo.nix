{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  programs.helix.settings.theme = lib.mkForce "alabaster";
  programs.zellij.settings.theme = "iceberg-light";

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  programs.beets = {
    enable = true;
  };

  home.sessionVariables = {
    WRTAG_ADDON = "musicdesc,replaygain";
    WRTAG_PATH_FORMAT = ''/home/dln/Music/Library/{{ artists .Release.Artists | sort | join \": \" | safepath }}/{{ .Release.Title | safepath }}{{ if not (eq .ReleaseDisambiguation \"\") }} ({{ .ReleaseDisambiguation | safepath }}){{ end }} ({{ .Release.ReleaseGroup.FirstReleaseDate.Year }})/{{ pad0 2 .TrackNum }}.{{ len .Tracks | pad0 2 }} {{ if .IsCompilation }}{{ artistsString .Track.Artists | safepath }} - {{ end }}{{ .Track.Title | safepath }}{{ .Ext }}'';
  };

  home.packages = with pkgs; [
    stable.calibre
    beets
    essentia-extractor
    picard
    rsgain
    wrtag
  ];
}
