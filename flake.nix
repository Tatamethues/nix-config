{
  description = "A template that shows all standard flake outputs";
  
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
  };
 
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          modules = [
            ./os/configuration.nix                    
          ];
        };
      };
      homeConfigurations = {
        "colin" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
         };
      };
    };
}
