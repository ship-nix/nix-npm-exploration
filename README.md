# nix-npm-exploration

Exploration in combined development environment and deployment with node/npm with Nix flakes.

- Super fast auto-reloading devShell with a [Nix flake](https://nixos.wiki/wiki/Flakes)
- Simple reload with esbuild
- Possibly even simpler than the traditional node/npm setup
- Simple to hook up to a NixOs server provisioned with [ship-nix.com](https://ship-nix/com)

**WORK IN PROGRESS**

[TOC]

# Get started

For the most seamless developer experience, [have direnv installed in your system](https://direnv.net/) and [hook it to your shell]().

## Generate production code locally

```bash
nix build
```

Se output of production build in generated `result` folder.

## Run development server

### If no direnv installed

Enter development shell:

```bash
nix develop
```

### If you use direnv

The devShell will be automatically loded, and you don't need to run `nix-develop` manually.

## Running `npm install` not needed.

`flake.nix` will use [serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) to read `package-lock.json` to create a build derivation.

## Nix reproducible node development environments across systems

As soon as `package-lock.json` changes, your development shell will be automatically updated.

Then you can run the watch script like you would in a traditional node environment:

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

You might be surprised to discover that `node_modules` will not appear in your project directory at any time, even when installing and removing packages.

As soon as `package-lock.json` changes, your development shell will be automatically updated and point to an updated node_modules folder from your nix shell environment (if using direnv).

If the dev server is running, you might need to press `ctrl+C` to stop the server and start `npm run watch` up again for it to catch up.
