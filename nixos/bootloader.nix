{
  pkgs,
  self,
lib,
  ...
}: {
  # boot.loader.systemd-boot = {
  #   enable = true;
  #   configurationLimit = 3;
  # };

  boot.loader.grub = {
    enable = true; # เปิดใช้งาน GRUB
    devices = ["nodev"]; # กำหนดอุปกรณ์ที่ติดตั้ง GRUB (สำหรับ BIOS)
    efiSupport = true; # เปิดใช้งาน UEFI support
    efiInstallAsRemovable = false; # ติดตั้ง GRUB ในโหมด removable (สำหรับบางระบบ UEFI)
    useOSProber = true; # ตรวจสอบระบบปฏิบัติการอื่นๆ อัตโนมัติ
    configurationLimit = 3;
    configurationName = "NixOS"; # ชื่อ configuration ใน GRUB menu
    # extraEntries = ''      # เพิ่ม boot entries เอง
    #       menuentry "Windows Boot Manager" {
    #         insmod part_gpt
    #         insmod fat
    #         insmod chain
    #         search --fs-uuid --set=root <UUID_OF_EFI_PARTITION>
    #         chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    #       }
    # '';
    # extraConfig = ''
    #      # set timeout=5
    #   GRUB_DISABLE_SUBMENU=true
    #   GRUB_TIMEOUT=5
    # '';
    theme = lib.mkForce (pkgs.stdenv.mkDerivation {
      name = "grub-theme";
      src = "${self}/assets/grubTheme/Rin.tar";
      installPhase = ''
        mkdir -p $out
        cp -r ./* $out/
      '';
    });
    # splashImage = null; # ปิดการใช้งาน splash image หากไม่ต้องการ
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
