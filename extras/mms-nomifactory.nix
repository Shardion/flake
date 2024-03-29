# commented due to fractureiser

/*{ lib, config, pkgs, inputs, ... }:

{
  services.modded-minecraft-servers = {
    eula = true;
    instances = {
      nomifactory = {
        enable = true;
        rsyncSSHKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILwRMru/RoUyp7eTnS09HgeJ0Cz9JIYjvC4Gxc9FAhL3 shardion's ssh key" ]; # This has to be specified or MMS explodes

        jvmMaxAllocation = "6G";
        jvmInitialAllocation = "3G";

        # BTM java 8 + server G1GC + transparent huge pages + log4shell fix.
        # Used because tama needs as much performance as possible and isn't starved for RAM in this context.
        # BTM flags are otherwise much worse for RAM consumption.
        jvmOpts = "-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+AlwaysActAsServerClassMachine -XX:+ParallelRefProcEnabled -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:MaxInlineLevel=15 -XX:MaxVectorSize=32 -XX:+UseCompressedOops -XX:ThreadPriorityPolicy=1 -XX:+UseNUMA -XX:+UseDynamicNumberOfGCThreads -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=350M -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+UseFPUForSpilling -Dgraal.CompilerConfiguration=community -XX:+UseG1GC -XX:MaxGCPauseMillis=130 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=28 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcRSHotCardLimit=16 -XX:G1ConcRefinementServiceIntervalMillis=150 -XX:+UseTransparentHugePages -Dlog4j.configurationFile=log4j2_112-116.xml";
      
        serverConfig = {
          server-port = 25565;

          # Color codes and newlines work just fine in server.properties.
          # Control codes are escaped so Minecraft parses them instead of Nix.
          motd = "\\u00A77Enchian Nomifactory. Draedon is coming.\\u00A7r\\n\\u00A78[MID \"Nebula\" @ tama]\\u00A7r \\u00A73.//\\u00A7r";

          enable-rcon = false; # Explicitly set here just in case

          # Default in Nomifactory so it's what we're using here
          level-type="lostcities";

          # I have no clue why this is a default.
          spawn-protection = 0;

          # (This implies we'll ever unlock flight)
          allow-flight = true;
        };
      };
    };
  };
}*/