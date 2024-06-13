{
  inputs = {
    # TODO (tff): explicitly call out nixpkgs version
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          cmake # version >3.13 is required according to the docs
          gnumake
          ruby
          libgcc

          # Can be used as a break-glass
          # cmake -DCOMPILER_VERSION_CHECK=OFF ..
          gcc-arm-embedded-13 # Cmake expects 13.2.1

          # TODO (tff): get ninja in here and try that too
        ];
      };
    }
  );
}
