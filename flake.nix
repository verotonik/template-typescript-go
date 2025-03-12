{
  inputs = {
    garnix-lib.url = "github:garnix-io/garnix-lib";
    Haskell.url = "github:garnix-io/haskell-module";
    NodeJS.url = "github:garnix-io/nodejs-module";
    PostgreSQL.url = "github:garnix-io/postgresql-module";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  outputs = inputs: inputs.garnix-lib.lib.mkModules {
    modules = [
      inputs.Haskell.garnixModules.default
      inputs.NodeJS.garnixModules.default
      inputs.PostgreSQL.garnixModules.default
    ];

    config = { pkgs, ... }: {
      haskell = {
        haskell-project = {
          buildDependencies = [  ];
          devTools = [  ];
          ghcVersion = "9.8";
          runtimeDependencies = [  ];
          src = ./.;
          webServer = null;
        };
      };
      nodejs = {
        nodejs-project = {
          buildDependencies = [  ];
          devTools = [  ];
          prettier = true;
          runtimeDependencies = [  ];
          src = ./.;
          testCommand = "npm run test";
          webServer = null;
        };
      };
      postgresql = {
        postgresql-project = {
          port = 5432;
        };
      };

      garnix.deployBranch = "main";
    };
  };
}
