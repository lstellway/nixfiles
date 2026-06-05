# @see https://herdr.dev/docs/
{ ... }: {
  xdg.configFile."herdr/config.toml".source = ./config.toml;
}
