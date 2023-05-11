# Be warned: this file is the product of an incomplete machine refactor.
# It does not function, yet.

{ }:

{ name ? "machine"
, character ? "💻"
, description ? "No description."
, hardware ? [ ]
, users ? [ "shardion" ]
, roles ? [ "desktop" ]
, extras ? [ ]
} @ args: {
  imports = [
    
  ] ++ map (role: "./system/" + role) roles
    ++ map (extra: "./extras/" + extra) extras
    ++ map (component: "./hardware/" + component) hardware
    ++ map (user: map (role: "./user/" + user + role) roles) users;

    name = name;
    character = character;
    description = description;

    networking.hostName = name;
}