# @see https://nix-community.github.io/home-manager/options.xhtml#opt-programs.k9s.enable
# @see https://k9scli.io/topics/config/
# @see https://github.com/derailed/k9s/blob/3ef5415d6264bd0005f1db4dd66847b1d793c0e6/skins/
{ pkgs, ... }: {
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        skin = "transparent";
      };
    };
    skins = {
      transparent = {
        k9s = {
          body = { bgColor = "default"; };
          prompt = { bgColor = "default"; };
          info = { sectionColor = "default"; };
          dialog = {
            bgColor = "default";
            labelFbColor = "default";
            fieldFgColor = "default";
          };
          frame = {
            crumbs = { bgColor = "default"; };
            title = { bgColor = "default"; counterColor = "default"; };
            menu = { fgColor = "default"; };
          };
          views = {
            charts = { bgColor = "default"; };
            table = {
              bgColor = "default";
              header = { fgColor = "default"; bgColor = "default"; };
            };
            xray = { bgColor = "default"; };
            logs = {
              bgColor = "default";
              indicator = { bgColor = "default"; toggleOnColor = "default"; toggleOffColor = "default"; };
            };
            yaml = { colonColor = "default"; valueColor = "default"; };
          };
        };
      };
    };
  };
}

