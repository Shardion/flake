# Be warned: this file is the product of an incomplete machine refactor.
# It does not function, yet.

{ }:

{ name ? "machine"
, character ? "💻"
, description ? "No description."
, hardware ? [ ]
, users ? [ "shardion" ]
, roles ? [ "desktop" ]
, specializations ? [ ]
} @ args: {
  imports = [
    
  ] ++ map (role: "./system/" + role) roles
    ++ map (specialization: "./specializations/" + specialization) specializations
    ++ map (component: "./hardware/" + component) hardware
    ++ map (user: map (role: "./user/" + user + role) roles) users;

    name = name;
    character = character;
    description = description;

    networking.hostName = name;
}