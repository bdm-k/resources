{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      username = import ./username.nix;
      programs = "/Users/${username}/resources/programs";

      safe-rm = import
        "${programs}/safe-rm/default.nix"
        { inherit pkgs; };

      app-switcher = import
        "${programs}/app-switcher/default.nix"
        { inherit (pkgs) stdenv; };

      repo-sync = import
        "${programs}/repo-sync/default.nix"
        { inherit pkgs; };
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit pkgs-stable;
          programs = { inherit safe-rm app-switcher repo-sync; };
        };
      };
    };
}
