#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "uo_main", "ace__laser", "a3_ui_f", "a3_weapons_f" };
		version = VERSION;
	};
};

#include "CfgEventhandlers.hpp"
#include "CfgOptics.hpp"