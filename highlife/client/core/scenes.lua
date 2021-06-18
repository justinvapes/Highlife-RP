local Config = {}

Config.Scenes = {
	DefaultScenePed = GetHashKey('ig_bankman'),

	Anims = {
		Knockout_Michael = {
			animDict = 'friends@frm@ig_2',
			animPlayer = 'knockout_mic',

			audioEvent = 'MICHAEL_KNOCKOUT_FAFM_ANAA_0',

			animOther = {
				anim = 'knockout_player',
				ped = nil
			},

			animCam = 'knockout_cam',

			holdScene = false,
			loopScene = false
		},
		Knockout_Trevor = {
			animDict = 'friends@frt@ig_2',
			animPlayer = 'knockout_trevor',

			animOther = {
				anim = 'knockout_player',
				ped = nil
			},

			animCam = 'knockout_cam',

			holdScene = false,
			loopScene = false
		},
		Cuff = {
			animDict = 'mp_arrest_paired',
			animPlayer = 'cop_p3_fwd',

			animOther = {
				anim = 'crook_p3',
				ped = nil
			},

			holdScene = false,
			loopScene = false
		},
		Uncuff = {
			animDict = 'mp_arresting',
			animPlayer = 'a_uncuff',

			animOther = {
				anim = 'b_uncuff',
				ped = nil
			},

			animCam = 'cam_uncuff',

			holdScene = false,
			loopScene = false
		},
		CPR = {
			animDict = 'missheistfbi3b_ig8_2',
			animPlayer = 'cpr_loop_paramedic',

			animOther = {
				anim = 'cpr_loop_victim',
				ped = nil
			},

			holdScene = false,
			loopScene = true
		},
		Drag = {
			animDict = 'combat@drag_ped@',
			animPlayer = 'injured_drag_plyr',

			animOther = {
				anim = 'injured_drag_ped',
				ped = nil
			},

			holdScene = false,
			loopScene = true
		},
		Newspaper = {
			animDict = 'missmic3',
			animPlayer = 'newspaper_idle_outro_dave',

			animObject = {
				prop = GetHashKey('p_cs_newspaper_s'),
				anim = 'newspaper_idle_outro_newspaper',
			},

			holdScene = false,
			loopScene = false
		},
		Telescope = {
			animDict = 'mini@telescope',
			animPlayer = 'public_enter_front',

			animObject = {
				findObject = GetHashKey('prop_telescope_01'),
				findOffset = true,
				offsetHeading = 240.0
			},

			holdScene = false,
			loopScene = false
		},
		SharkAttack = {
			animDict = 'creatures@shark@move',
			animPlayer = 'attack_player',

			animOther = {
				anim = 'attack',
				ped = GetHashKey('a_c_sharktiger')
			},

			animCam = 'attack_cam',

			holdScene = false,
			loopScene = false
		},
		Throwout = {
			animDict = 'mini@strip_club@throwout_d@',
			animPlayer = 'throwout_d_victim',

			offset = vector3(0.0, 0.0, -0.3),

			animOther = {
				anim = 'throwout_d_bouncer_b',
				ped = GetHashKey('player_two')
			},

			animCam = 'throwout_d_cam',

			holdScene = false,
			loopScene = false
		},
		Handshake = {
			animDict = 'anim@mp_player_intcelebrationpaired@m_m_manly_handshake',
			animPlayer = 'manly_handshake_left',

			animOther = {
				anim = 'manly_handshake_right',
				ped = 'player'
			},

			holdScene = false,
			loopScene = false
		}
	}
}

function PlaySceneAnim(sceneName)
	if Config.Scenes.Anims[sceneName] ~= nil then
		local thisScene = {
			netID = nil,
			locID = nil,

			offsetPos = nil,

			ped = nil,
			object = nil
		}

		if Config.Scenes.Anims[sceneName].animDict == nil then
			return
		end

		CreateThread(function()
			if not HasAnimDictLoaded(Config.Scenes.Anims[sceneName].animDict) then
				RequestAnimDict(Config.Scenes.Anims[sceneName].animDict)

				repeat Wait(1) until HasAnimDictLoaded(Config.Scenes.Anims[sceneName].animDict)
			end

			if Config.Scenes.Anims[sceneName].animObject ~= nil then
				if Config.Scenes.Anims[sceneName].animObject.findObject ~= nil then
					local foundObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, Config.Scenes.Anims[sceneName].animObject.findObject, false, 0, 0)

					if foundObject ~= 0 then
						thisScene.object = foundObject

						if Config.Scenes.Anims[sceneName].animObject.findOffset then
							thisScene.offsetPos = GetAnimInitialOffsetPosition(Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animPlayer, GetEntityCoords(thisScene.object))
						end
					end
				else
					if not HasModelLoaded(Config.Scenes.Anims[sceneName].animObject.prop) then
						RequestModel(Config.Scenes.Anims[sceneName].animObject.prop)

						repeat Wait(1) until HasModelLoaded(Config.Scenes.Anims[sceneName].animObject.prop)
					end

					thisScene.object = CreateObject(Config.Scenes.Anims[sceneName].animObject.prop, HighLife.Player.Pos, true, true, true)

					SetModelAsNoLongerNeeded(Config.Scenes.Anims[sceneName].animObject.prop)
				end
			end

			if Config.Scenes.Anims[sceneName].animOther ~= nil then
				if Config.Scenes.Anims[sceneName].animOther.ped ~= 'player' then
					if not HasModelLoaded(Config.Scenes.Anims[sceneName].animOther.ped or Config.Scenes.DefaultScenePed) then
						RequestModel(Config.Scenes.Anims[sceneName].animOther.ped or Config.Scenes.DefaultScenePed)

						repeat Wait(1) until HasModelLoaded(Config.Scenes.Anims[sceneName].animOther.ped or Config.Scenes.DefaultScenePed)
					end

					thisScene.ped = CreatePed(4, Config.Scenes.Anims[sceneName].animOther.ped or Config.Scenes.DefaultScenePed, HighLife.Player.Pos, 0.0, true, false)

					SetModelAsNoLongerNeeded(Config.Scenes.Anims[sceneName].animOther.ped or Config.Scenes.DefaultScenePed)
				else
					-- do it with a player
					thisScene.ped = GetPlayerPed(127)
				end
			end

			if thisScene.offsetPos ~= nil then
				print(GetEntityHeading(thisScene.object))

				TaskGoStraightToCoord(HighLife.Player.Ped, thisScene.offsetPos, 1.0, 2000, (Config.Scenes.Anims[sceneName].animObject.offsetHeading ~= nil and (Config.Scenes.Anims[sceneName].animObject.offsetHeading - GetEntityHeading(thisScene.object)) or GetEntityHeading(thisScene.object)), 0.0)

				Wait(2000)
			end

			thisScene.netID = NetworkCreateSynchronisedScene((thisScene.object ~= nil and GetEntityCoords(thisScene.object) or (HighLife.Player.Pos + (Config.Scenes.Anims[sceneName].offset ~= nil and Config.Scenes.Anims[sceneName].offset or vector3(0.0, 0.0, -1.0)))), 0.0, 0.0, ((thisScene.object ~= nil) and GetEntityHeading(thisScene.object) or HighLife.Player.Heading), 2, Config.Scenes.Anims[sceneName].holdScene, Config.Scenes.Anims[sceneName].loopScene, 1065353216, 0, 1065353216)

			NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, thisScene.netID, Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animPlayer, 8.0, -8.0, 13, 16, 1148846080, 0)

			if Config.Scenes.Anims[sceneName].animOther ~= nil and Config.Scenes.Anims[sceneName].animOther.anim ~= nil and thisScene.ped ~= nil then
				NetworkAddPedToSynchronisedScene(thisScene.ped, thisScene.netID, Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animOther.anim, 8.0, -8.0, 13, 16, 1148846080, 0)
			end

			if Config.Scenes.Anims[sceneName].animObject ~= nil and Config.Scenes.Anims[sceneName].animObject.findObject == nil and thisScene.object ~= nil then
				NetworkAddEntityToSynchronisedScene(thisScene.object, thisScene.netID, Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animObject.anim, 8.0, -8.0, 1)
			end

			if Config.Scenes.Anims[sceneName].animCam ~= nil then
				NetworkForceLocalUseOfSyncedSceneCamera(thisScene.netID, Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animCam)
			end

			NetworkStartSynchronisedScene(thisScene.netID)

			repeat Wait(1) until (NetworkConvertSynchronisedSceneToSynchronizedScene(thisScene.netID) ~= -1)

			thisScene.locID = NetworkConvertSynchronisedSceneToSynchronizedScene(thisScene.netID)

			-- if Config.Scenes.Anims[sceneName].audioEvent ~= nil and thisScene.locID ~= nil then
			--     repeat Wait(1) until PrepareSynchronizedAudioEvent(Config.Scenes.Anims[sceneName].audioEvent, 0)

			--     PlaySynchronizedAudioEvent(thisScene.locID)

			--     print('playing')
			-- end

			RemoveAnimDict(Config.Scenes.Anims[sceneName].animDict)

			if not Config.Scenes.Anims[sceneName].loopScene then
				Wait(math.floor(GetAnimDuration(Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animPlayer) * 1000))
			else
				Wait(100)
				
				while IsEntityPlayingAnim(HighLife.Player.Ped, Config.Scenes.Anims[sceneName].animDict, Config.Scenes.Anims[sceneName].animPlayer, 2) do
					Wait(1)
				end
			end

			if thisScene.ped ~= nil and Config.Scenes.Anims[sceneName].animOther.ped ~= 'player' then
				DeletePed(thisScene.ped)
			end

			if thisScene.object ~= nil then
				DeleteEntity(thisScene.object)
			end
		end)
	end
end

RegisterCommand('playscene', function(some, args, idk)
	if HighLife.Player.Special or HighLife.Settings.Development then
		PlaySceneAnim(args[1])
	end
end)