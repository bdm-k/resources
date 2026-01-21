{
  description = "My Home Manager configuration";

  inputs = {
    # To update nixpkgs, run:
    # ```
    # nix flake update nixpkgs
    # ```
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/12a55407652e04dcf2309436eb06fef0d3713ef3";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      username = import ./username.nix;
      programs = "/home/${username}/resources/programs";

      starship_agnocast_kmod = import
        "${programs}/starship_agnocast_kmod/default.nix"
        { inherit pkgs; };

      safe-rm = import
        "${programs}/safe-rm/default.nix"
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
          programs = { inherit starship_agnocast_kmod safe-rm; };
        };
      };
    };
}
