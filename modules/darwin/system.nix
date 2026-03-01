inputs: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = ({ self, ... }: self.rev or self.dirtyRev or null) inputs;

  # Define primary user
  system.primaryUser = builtins.head (builtins.attrNames inputs.users);

  # Global system preferences
  # @see https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls
  system.defaults.NSGlobalDomain = {
    AppleICUForce24HourTime = true;
    AppleInterfaceStyleSwitchesAutomatically = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    AppleShowScrollBars = "Always";
    InitialKeyRepeat = 12;
    KeyRepeat = 2;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    NSAutomaticWindowAnimationsEnabled = false;
    NSDisableAutomaticTermination = true;
    NSDocumentSaveNewDocumentsToCloud = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    NSScrollAnimationEnabled = true;
    NSTableViewDefaultSizeMode = 2;
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
    "com.apple.mouse.tapBehavior" = 1;
    # "com.apple.sound.beep.feedback" = 0;
    "com.apple.sound.beep.volume" = 0.25;
    "com.apple.swipescrolldirection" = true;
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.scaling" = 3.0;
  };

  # @see https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-security.pam.services.sudo_local.touchIdAuth
  # security.pam.services.sudo_local = {
  #   enable = true;
  #   reattach = true;
  #   touchIdAuth = true;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # @see https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = inputs.system;
}
