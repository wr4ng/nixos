{ ... }:

{
	#TODO: Move to home-manager modules. Need to find a clean way to import the right place
	programs.git = {
		enable = true;
		userName = "Mads Christian Wrang Nielsen";
		userEmail = "madscwn@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
		};
	};
	programs.lazygit.enable = true;
	programs.gh.enable = true;
}
