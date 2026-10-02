# Proprietary NVIDIA driver, configured through a small option set so the
# module itself stays generic and the host only supplies hardware facts.
#
#   custom.nvidia.enable = true;
#   # Hybrid laptop (Intel iGPU + NVIDIA dGPU) -> set BOTH bus IDs (PRIME offload):
#   custom.nvidia.prime.intelBusId  = "PCI:0:2:0";
#   custom.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
#   # NVIDIA-only machine -> leave both bus IDs unset.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.nvidia;
  hybrid = cfg.prime.intelBusId != null && cfg.prime.nvidiaBusId != null;
in {
  options.custom.nvidia = {
    enable = lib.mkEnableOption "the proprietary NVIDIA driver";

    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Use NVIDIA's open kernel modules. Supported on Turing and newer
        GTX(16xx / RTX 20xx and later). Set to false for older GPUs.
      '';
    };

    package = lib.mkOption {
      type = lib.types.str;
      default = "stable";
      example = "legacy_580";
      description = "Attribute name indside boot.kernelPackages.nvidiaPackages.";
    };

    prime = {
      intelBusId = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "PCI:0:2:0";
      };
      nvidiaBusId = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "PCI:1:0:0";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = (cfg.prime.intelBusId == null) == (cfg.prime.nvidiaBusId == null);
        message = "custom.nvidia.prime: set both intelBusId and nvidiaBusId, or neither";
      }
    ];

    # Required even on Wayland: this is what loads the driver.
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true; # needed for Wayland/Hyprland
      open = cfg.open;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.package};

      # Fixes broken/black screen after suspend
      powerManagement.enable = true;
      powerManagement.finegrained = hybrid && cfg.open;

      # Hybrid: iGPU drives the display, dGPU is used on demand via 'nvidia-offload <cmd>'.
      prime = lib.mkIf hybrid {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = cfg.prime.intelBusId;
        nvidiaBusId = cfg.prime.nvidiaBusId;
      };
    };

    # NVIDIA-only: make everything use the NVIDIA GPU. Must NOT be set on
    # hybrid, or it would force every app onto the dGPU.
    environment.sessionVariables = lib.mkIf (!hybrid) {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };
    hardware.graphics.extraPackages = lib.mkIf (!hybrid) [pkgs.nvidia-vaapi-driver];
  };
}
