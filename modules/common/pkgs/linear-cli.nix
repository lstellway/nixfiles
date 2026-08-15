{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "linear-cli";
  version = "0.3.27";

  src = fetchFromGitHub {
    owner = "nesszer";
    repo = "linear-cli";
    rev = "v${version}";
    hash = "sha256-ikJ2JMoDsF3t7nFTfp1+HzNjCGJ058Wk0SFF1ukKGOA=";
  };

  cargoHash = "sha256-udYtgOnZ8aRRqji91pwVMQU2bXkSvdlWNUvyyvHPQRA=";

  # Some tests write config files under $HOME, which isn't writable in the build sandbox.
  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = {
    description = "A powerful CLI for Linear.app - manage issues, projects, cycles, and more from your terminal";
    homepage = "https://github.com/nesszer/linear-cli";
    license = lib.licenses.mit;
    mainProgram = "linear-cli";
  };
}
