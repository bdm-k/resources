{
  description = "My Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-opencode.url = "github:nixos/nixpkgs/ea30586ee015f37f38783006a9bc9e4aa64d7d61";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-stable, nixpkgs-opencode, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      opencode = nixpkgs-opencode.legacyPackages.${system}.opencode;

      username = import ./username.nix;
      programs = "/Users/${username}/resources/programs";

      safe-rm = import
        "${programs}/safe-rm/default.nix"
        { inherit pkgs; };

      app-switcher = import
        "${programs}/app-switcher/default.nix"
        { inherit (pkgs) stdenv; };
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
          inherit pkgs-stable opencode;
          programs = { inherit safe-rm app-switcher opencode; };
        };
      };
    };
}
