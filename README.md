# A nix/npm exploration of node.js in production and development

Exploration in combined development environment and deployment environment with node/npm with Nix flakes.

## What I have achieved in building so far

- [x] Super fast auto-reloading development shell with a [Nix flake](https://nixos.wiki/wiki/Flakes)
- [x] Automatically load auto-reloading nix development shell with direnv
- [x] Manage dependencies with npm's CLI, but in reality actually fetch and build packages via Nix, both in development and production

## TODO

- [ ] Make a NixOs configuration that works with [ship-nix.com](https://ship-nix/com) for easy deployment to DigitalOcean
- [ ] Use a bundler like Parcel or Vite to make HMR (Hot Module Reloading)
- [ ] Test use on Mac, non-NixOs and Windows

**WORK IN PROGRESS**

[TOC]

# Get started

You need to have [Nix](https://nixos.org/download.html#download-nix) installed.

You can try it for yourself by cloning this repository:

```bash
git clone https://github.com/ship-nix/nix-npm-exploration.git
cd nix-npm-exploration
```

## Enable experimental Nix flakes

The Nix flakes system is built into NixOs and one of the most exciting new features for the NixOs ecosystem.

It's still considered experimental feature of Nix, so you need to enable Nix flakes on your system.

- [How to enable Nix flakes (nixos.wiki)](<(https://nixos.wiki/wiki/Flakes#Enable_flakes)>)

## direnv (highly recommended)

For the most seamless developer experience, use direnv:

1. [have direnv installed in your system](https://direnv.net/docs/installation.html)
2. [hook it to your shell](https://direnv.net/docs/hook.html).

## Generate production code locally

If you want to see the generated code, run

```bash
nix build
```

If the build went well, you can inspect the production build in the `result` folder.

## Load development environment

### Only if direnv is not installed

Enter development shell:

```bash
nix develop
```

You will need to exit and reload the shell each time you update your node dependencies.

### With direnv

direnv will automatically load the development environment, and you don't need to run `nix-develop` manually if you have it enabled.

## Running `npm install` not needed.

`flake.nix` will use [serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) to read `package-lock.json` and pull npm libraries via Nix.

## Run development Shell

You can run the development script like you would in a regular node environment:

```bash
npm run watch
```

## Installing and removing packages

For node developers, this way of adding and removing npm packages should be familiar:

```bash
npm install express
npm remove express
```

You might be surprised to discover that `node_modules` will **not** appear in the project directory at any time, even when installing and removing npm packages.

[serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) targets `package-lock.json` and fetches the packages via Nix.

If the dev server is running during `npm install/remove`, you might need to press `ctrl+C` to stop it and start `npm run watch` up again for changes to be reflected.
