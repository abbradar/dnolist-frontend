{ stdenv, lib, makeWrapper, bundlerEnv, ruby }:

let env = bundlerEnv {
  name = "dnolist-frontend-deps";

  inherit ruby;
  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;
  gemset = ./gemset.nix;
};

in stdenv.mkDerivation {
  name = "dnolist-frontend";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  buildCommand = ''
    mkdir -p $out
    cp frontend.rb $out
    cp -r views $out
    patchShebangs $out/frontend.rb
    wrapProgram $out/frontend.rb \
      ${lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "--set ${k} ${v}") env.vars)}
  '';
}
