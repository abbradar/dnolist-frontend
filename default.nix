{ lib, bundlerEnv, ruby }:

bundlerEnv {
  name = "frontend";

  inherit ruby;
  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;
  gemset = ./gemset.nix;
}
