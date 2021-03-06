/*
 * Author: esteldunedain
 * Load the parameters on the server.
 * Config < Server UserConfig < Mission Config
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

GVAR(settings) = [];

_parseConfigForSettings = {
    private ["_config", "_countOptions", "_optionEntry", "_index"];

    _config = _this select 0;
    _countOptions = count _config;
    for "_index" from 0 to (_countOptions - 1) do {
        _optionEntry = _config select _index;
        [_optionEntry] call FUNC(setSettingFromConfig);
    };
    // Check if all settings should be forced
    if (GVAR(forceAllSettings)) then {
        {
            _x set [6, true];
        } forEach GVAR(settings);
    };
};

// Order is this way because:
// ACE_Settings should never force any setting by default. Loading it first ensures that all settings from ACE_Settings exist.
// This way, ACE_ServerSettings will override ACE_Settings, even if no force is used.
// Mission settings will override the server config settings, if no force is used.
// This ensures that all settings are of their correct type, in case an outdated or corrupt server config is used , as well as have their correct localized display name and description

// Regular config
[configFile >> "ACE_Settings"] call _parseConfigForSettings;

// Server config
[configFile >> "ACE_ServerSettings"] call _parseConfigForSettings;

// mission side settings
[missionConfigFile >> "ACE_Settings"] call _parseConfigForSettings;

// Publish all settings data
publicVariable QGVAR(settings);
// Publish all setting values
{
    publicVariable (_x select 0);
} forEach GVAR(settings);
