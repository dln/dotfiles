{
  config,
  lib,
  pkgs,
  ...
}:
let
  pamNamespacePatched = pkgs.pam.overrideAttrs (old: {
    pname = "pam-namespace-patched";
    postPatch = (old.postPatch or "") + ''
      sed -i \
        -e 's|SCONFIG_DIR "/namespace.conf"|"/etc/security/namespace.conf"|g' \
        -e 's|SCONFIG_DIR "/namespace.init"|"/etc/security/namespace.init"|g' \
        -e 's|SCONFIG_DIR "/namespace.d/"|"/etc/security/namespace.d/"|g' \
        -e 's|SCONFIG_DIR "/namespace.d/\*.conf"|"/etc/security/namespace.d/*.conf"|g' \
        modules/pam_namespace/pam_namespace.h
    '';
  });

in
{

  environment.etc."security/namespace.conf".text = ''
    /tmp/user  /tmp/user-inst/  user  root  mntopts=nodev,nosuid  iscript=/etc/security/namespace.init,ignore_instance_parent_mode
  '';

  environment.etc."security/namespace.init" = {
    mode = "0755";
    source = pkgs.writeScript "namespace-init" ''
      #!/bin/sh
      # $1=polydir  $2=instance_dir  $3=is_new(0|1)  $4=username
      /run/current-system/sw/bin/chown "$4" "$2"
      /run/current-system/sw/bin/chmod 0700 "$2"
    '';
  };

  systemd.tmpfiles.rules = [
    "d /tmp/user-inst 0000 root root -"
    "d /tmp/user 0755 root root -"
  ];

  security.pam.services =
    let
      addNamespace =
        name:
        lib.nameValuePair name {
          rules.session.pam_namespace = {
            order = 10500;
            control = "required";
            modulePath = "${pamNamespacePatched}/lib/security/pam_namespace.so";
            args = [
              "mount_private"
              "debug"
            ];
          };
        };
    in
    builtins.listToAttrs (
      map addNamespace [
        "kde"
        "lightdm"
        "lightdm-autologin"
        "lightdm-greeter"
        "login"
        "sddm"
        "sddm-autologin"
        "sddm-greeter"
        "sshd"
        "su"
        "su-l"
        "sudo"
        "systemd-user"
      ]
    );

  environment.sessionVariables.TMPDIR = "/tmp/user";
}
