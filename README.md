# A nix/npm exploration of node.js Nix flake for production and dev shell

**This is a work in progress, but already a great display for the power of a Node/Nix dev environment**

Exploration in combined development environment and deployment environment with node/npm with Nix flakes.

## What I have achieved in building so far

- [x] Super fast incrementally updating shell with a [Nix flake](https://nixos.wiki/wiki/Flakes) and efficient nix caching
- [x] Auto-reloading nix dev shell with direnv
- [x] Read package-lock.json, and build with nix, with no extra Nix code generation
- [x] Manage dependencies with npm's native CLI, but actually fetch and build packages via Nix, both in development shell and production build

## TODO

- [ ] Make a NixOs configuration that works with [ship-nix.com](https://ship-nix/com) for easy deployment to DigitalOcean
- [ ] Use a bundler like Parcel or Vite to enable HMR (Hot Module Reloading)
- [ ] Test use on Mac, non-NixOs and Windows

# Prerequisites

- You need to have [Nix](https://nixos.org/download.html#download-nix) installed
- You need to enable Nix Flakes, [see below](#)

# Get started

You can check out the dev environment for yourself by cloning this repository:

```bash
git clone https://github.com/ship-nix/nix-npm-exploration.git
cd nix-npm-exploration
```

## Enable experimental Nix flakes

The Nix flakes system is built into NixOs and one of the most exciting new features for the NixOs ecosystem.

Flakes have become seemingly very reliable, but it is still considered a experimental feature of Nix, so you need to enable Nix flakes on your system.

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

If the build went well, you can inspect the output of a production build in the `result` folder.

## Load development environment

### Enter development shell manually

This should only be necessary if you are choosing to **not install** direnv:

```bash
nix develop
```

You will need to exit and reload the shell each time you update your node dependencies.

### With direnv

direnv will automatically load the development environment, and you don't need to run and rerun `nix-develop` manually. Updated shell with node dependencies will be automatically be added.

## Running `npm install` not needed.

`flake.nix` will use [serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) to read `package-lock.json` and pull npm libraries via Nix.

This means don't need to use the actual `npm install` command. Packages will be automacially upated live in the shell.

## Run development Shell

You can run the development script like you would in a regular node environment:

```bash
npm run watch
```

## Installing and removing packages

For node developers, this way of adding and removing npm packages should be familiar.

Install npm packages

```bash
npm install express
```

remove npm packages

```
npm remove express
```

You might be surprised to discover that `node_modules` will **not** appear in the project directory at any time, even when installing and removing npm packages.

[serokell/nix-npm-buildpackage](https://github.com/serokell/nix-npm-buildpackage) targets `package-lock.json` and fetches the packages via Nix.

If the dev server is running during `npm install/remove`, you might need to press `ctrl+C` to stop it and start `npm run watch` up again for direnv to update and changes to be reflected.
