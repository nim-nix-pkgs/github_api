{
  description = ''Nim wrapper for the GitHub API'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."github_api-master".dir   = "master";
  inputs."github_api-master".owner = "nim-nix-pkgs";
  inputs."github_api-master".ref   = "master";
  inputs."github_api-master".repo  = "github_api";
  inputs."github_api-master".type  = "github";
  inputs."github_api-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github_api-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}