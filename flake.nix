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
 
  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      vars = let 
        user_name = "colin";
        user_fullname= "Colin Shen";
        user_email = "colinshen.work@outlook.com";
      in {
        inherit user_name;
        specialArgs = {inherit user_name user_fullname user_email;} // inputs;
      };
    in {
      
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          # specialArgs = { inherit (vars) user_name; };
          inherit (vars) specialArgs;
          modules = [
            ./os/configuration.nix                    
            home-manager.nixosModules.home-manager{
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${vars.user_name} = import ./home;
              home-manager.extraSpecialArgs = vars.specialArgs;
            }
          ];
        };
      };
    };
}
