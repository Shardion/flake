# shardion's NixOS configuration
*'Ever heard something about... I don't know, polished mud balls?'*

This is my NixOS configuration. It's not the best in the world, but it works.
And it plays osu! pretty well.

# Overview
<!--*'Because sorting is cool.'*-->

My NixOS configuration is split into five main sections:

- Machines
- Hardware
- System
- User
- Assets

Below are explanations of the purpose of every single section.

## Machines
<!--*'Shape the world to my design!'*-->

This section handles importing everything to suit a specific machine.

It doesn't do much on its own, as all of the files are just massive `import`s.

## Hardware
<!--*'Society would be a lot better if all hardware worked as well as a VM.'*-->

This section handles absolutely everything that is tied to a specific hardware configuration.
(Think of it as an advanced `nixos-hardware` for machines I've owned.)

This means it handles setting up optimal GPU performance (including proprietary drivers),
tweaks that only work on certain hardware, enabling support for specific hardware, etc.

Everything here is generic; it will work on any machine, provided you have the necessary hardware.
(Do note, the names of the files are rather generic as well, and the contents usually represent
a specific model of hardware. This means you likely won't be able to copy-paste anything in here,
unless you know your hardware works with it.)

## System
<!--*'What do you mean `system`? Everything is on the system!'*-->

Generally, this section handles everything that isn't specific to certain hardware or certain users.
Networking, desktop environments, global utilities, you name it, `system`'s got it.

`system` is split into multiple files, namely:

- `universal/`
  - `networking.nix`: Anything that has to do with networking, from Tailscale to DNSCrypt.
  - `utilities.nix`: Packages I couldn't live without when running as `root`.
  - `nix.nix`: Nix configuration. (You have to have Flake support to use Flakes!)
  - 

- `desktop/`
  - `desktop.nix`: Miscellaneous GUI and desktop-related things that didn't fit in any other files.
  - `desktop-gnome.nix`: A GNOME desktop.

## User
<!--*'Me!'*-->

Everything specific to a single user on a given system.

(There's only two separate profiles here, and they're both mine...)

- `shardion/`
  - `desktop/`: This is the home of all my tooling and games, as well as more specific customizations.
  - `server/`: This is where I keep my weapons of war against misbehaving servers.

## Assets
<!--*'A miserable little pile of secrets!'*-->

This section is a bit strange.
It handles everything that isn't Nix code or such; wallpapers, user profile photos, etc.
All of this is in encrypted tarballs on Git LFS. (Sorry if you wanted to see my wallpapers.)

# TODO
<!--*'Almost as eternal as the WinRAR free trial.'*-->

Naturally, there is things that I want done.
A short list, if anyone knows enough Nix and feels like helping.
(I will gladly accept pull requests.)

- 

# Credits
<!--*'Sorry, SimpleFlips, it's not your turn.'*-->

A big thanks to:

- [fufexan](), for making `nix-gaming` and consequently bringing low-latency PipeWire and easy Windows games to all
- [All of the Nix and NixOS contributors](), for rethinking package management and Linux as a whole
