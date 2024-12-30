{ pkgs, lib, config, ... }:

{
	options.programs = {
		ollama = {
			enable = lib.mkEnableOption "enables ollama + alpaca";
			acceleration = lib.mkOption {
				default = false;
				description = "acceleration mode to use for ollama. false for CPU only. 'cuda' or 'rocm' for nvidia and amd respectively";
			};
		};

	};

	config = lib.mkIf config.programs.ollama.enable {
		# Install ollama
		services.ollama = {
			enable = true;
			acceleration = config.programs.ollama.acceleration;
		};

		# Install alpaca, overriding with provided acceleration mode
		environment.systemPackages = with pkgs; [
			(if config.programs.ollama.acceleration == "cuda" then
				alpaca.override {
					ollama = ollama-cuda;
				}
			else if config.programs.ollama.acceleration == "rocm" then
				alpaca.override {
					ollama = ollama-rocm;
				}
			else
				alpaca)
		];

		# Assert that `acceleration` is set to either cudo, rocm or unset (no acceleration)
		assertions = [
			{
				assertion = config.programs.ollama.acceleration == false
					|| config.programs.ollama.acceleration == "cuda"
					|| config.programs.ollama.acceleration == "rocm";
				message = "config.ollama.acceleration must be one of: false, \"cuda\", or \"rocm\".";
			}
		];
	};
}
