-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}

local function onReset()
    electrics.values['supports_f'] = 0
    electrics.values['supports_f_input'] = 0
    electrics.values['hydros_fl'] = 0
    electrics.values['hydros_fl_input'] = 0
    electrics.values['hydros_fr'] = 0
    electrics.values['hydros_fr_input'] = 0
    electrics.values['supports_tilt'] = 0
    electrics.values['supports_tilt_input'] = 0
    electrics.values['supports_r'] = 0
    electrics.values['supports_r_input'] = 0
    electrics.values['hydros_rl'] = 0
    electrics.values['hydros_rl_input'] = 0
    electrics.values['hydros_rr'] = 0
    electrics.values['hydros_rr_input'] = 0
end

local function updateGFX(dt)
    electrics.values['supports_f'] = math.min(1, math.max(-0.0, (electrics.values['supports_f'] + electrics.values['supports_f_input'] * dt * 0.008)))
    electrics.values['hydros_fl'] = math.min(1, math.max(-0.0, (electrics.values['hydros_fl'] + electrics.values['hydros_fl_input'] * dt * 0.008)))
    electrics.values['hydros_fr'] = math.min(1, math.max(-0.0, (electrics.values['hydros_fr'] + electrics.values['hydros_fr_input'] * dt * 0.008)))
    electrics.values['supports_tilt'] = math.min(1, math.max(-0.0, (electrics.values['supports_tilt'] + electrics.values['supports_tilt_input'] * dt * 0.008)))
    electrics.values['supports_r'] = math.min(1, math.max(-0.0, (electrics.values['supports_r'] + electrics.values['supports_r_input'] * dt * 0.008)))
    electrics.values['hydros_rl'] = math.min(1, math.max(-0.0, (electrics.values['hydros_rl'] + electrics.values['hydros_rl_input'] * dt * 0.008)))
    electrics.values['hydros_rr'] = math.min(1, math.max(-0.0, (electrics.values['hydros_rr'] + electrics.values['hydros_rr_input'] * dt * 0.008)))
end

-- public interface
M.onInit    = onReset
M.onReset   = onReset
M.updateGFX = updateGFX

return M