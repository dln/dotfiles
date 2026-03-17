{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./desktop.nix
  ];

  programs.zellij.settings.theme = "iceberg-light";
  # programs.zellij.settings.theme = "ayu_dark";

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  home.sessionVariables = {
    WRTAG_ADDON = "musicdesc,replaygain";
    WRTAG_PATH_FORMAT = ''/home/dln/Music/Library/{{ artists .Release.Artists | sort | join \": \" | safepath }}/{{ .Release.Title | safepath }}{{ if not (eq .ReleaseDisambiguation \"\") }} ({{ .ReleaseDisambiguation | safepath }}){{ end }} ({{ .Release.ReleaseGroup.FirstReleaseDate.Year }})/{{ pad0 2 .TrackNum }}.{{ len .Tracks | pad0 2 }} {{ if .IsCompilation }}{{ artistsString .Track.Artists | safepath }} - {{ end }}{{ .Track.Title | safepath }}{{ .Ext }}'';
  };

  home.packages = with pkgs; [
    stable.calibre
    essentia-extractor
    picard
    rsgain
    wrtag
  ];

  # Sendspin
  systemd.user.services.sendspin-user-kontoret =
    let
      name = "Kontoret";
      id = "kontoret";
    in
    {
      Unit.Description = "sendspin player";
      Unit.After = [
        "graphical-session.target"
      ];
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = ''${pkgs.sendspin-cli}/bin/sendspin daemon --id ${id} --name ${name} --audio-device "pipewire" --audio-format flac:96000:24:2 --static-delay-ms -20 --port 8926'';
      };
    };
}
