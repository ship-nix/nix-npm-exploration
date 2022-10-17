# nix-npm-exploration

Exploration in figuring how to build a node/npm flake for both dev environment and nixos server configuration.

**WORK IN PROGRESS**

# direnv

For the most seamless developer experience, [have direnv installed in your system and hooked to your shell](https://direnv.net/).

# Build production package locally

```bash
nix build
```

Se output of production build in generated `result` folder.

# Run development server

## If you don`t use direnv

First enter development shell:

```bash
nix develop
```

## If you use direnv (recommended)

The devShell will be automatically loded, and you don't need to run `nix-develop`!

## Fully reproducible development environments across systems

No need to do `npm install` from here on.

`flake.nix` will use [serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) to create a build derivation and automatically reload the development shell when `package-lock.json` changes.

Then you can run the live reloading dev server script like you would in a traditional node environment:

```bash
npm run watch
```

## Installing and removing packages

For node developers, it should be quite familiar to add and remove npm packages:

```bash
npm install express
```

```bash
npm remove express
```

As npm inside this devShell environment is configured to only change `package-lock.json`, you should never see a `node_modules` folder in your project.

A symlink to the actual node_modules will be automatically updated in the running `devShell`.

If the dev server is running, you might need to press `ctrl+C` to stop the server and start `npm run watch` up again for changes to be reflected.
