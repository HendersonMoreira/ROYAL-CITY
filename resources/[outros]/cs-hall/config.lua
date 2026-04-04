config = {
    -- Set whether you want to be informed in your server's console about updates regarding this resource.
    ['updatesCheck'] = true,

    -- Enabling debug will draw lines useful for debugging, especially when creating a new config entry.
    ['debug'] = false,

    -- The DUI URL, by default loaded locally.
    ['duiUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/index.html',

    -- Strings through-out the resource to translate them if you wish.
    ['lang'] = {
        ['addToQueue'] = 'Add to Queue',
        ['bassSmoke'] = 'Bass Smoke',
        ['bassSparklers'] = 'Bass Sparklers',
        ['triggerSmoke'] = 'Trigger Smoke',
        ['triggerSparklers'] = 'Trigger Sparklers',
        ['whiteSpotlights'] = 'White Spotlights',
        ['dynamicSpotlights'] = 'Dynamic Spotlights',
        ['photorythmicSpotlights'] = 'Photorythmic Spotlights',
        ['videoToggle'] = 'Video Toggle',
        ['screenControl'] = 'Screen Control',
        ['remoteControl'] = 'Remote Control',
        ['play'] = 'Play',
        ['queueNow'] = 'Queue Now',
        ['queueNext'] = 'Queue Next',
        ['remove'] = 'Remove',
        ['pause'] = 'Pause',
        ['stop'] = 'Stop',
        ['skip'] = 'Skip',
        ['loop'] = 'Loop',
        ['volume'] = 'Volume',
        ['invalidUrl'] = 'URL invalid.',
        ['invalidYouTubeUrl'] = 'YouTube URL invalid.',
        ['invalidTwitchUrl'] = 'Twitch URL invalid.',
        ['urlPlaceholder'] = 'YouTube / Twitch URL',
        ['sourceError'] = 'Playable media error occured.',
        ['twitchChannelOffline'] = 'Twitch channel offline.',
        ['twitchVodSubOnly'] = 'Twitch video subs-only.',
        ['twitchError'] = 'Twitch error occured.',
        ['youtubeError'] = 'YouTube error occured.',
        ['sourceNotFound'] = 'Playable media not be found.',
        ['liveFeed'] = 'Live Feed',
        ['twitchClip'] = 'Twitch Clip',
        ['queueLimitReached'] = 'The queue has already too many entries.',
        ['scenes'] = 'Scenes',
        ['allUrlPlaceholder'] = 'URL',
        ['frame'] = 'Frame'
    },

    -- Loading related timeouts, default values should work in most servers.
    ['timeouts'] = {
        ['scaleformRequestMs'] = 30000,
        ['assetLoadMs'] = 30000,
        ['syncAssetLoadMs'] = 3000
    },

    -- Visit our Discord over at https://criticalscripts.shop/discord to get more entries and share yours too!

    ['entries'] = {
        -- Vanilla Unicorn
        -- If you are using the default Vanilla Unicorn or a similar variant of it, keep it enabled below.

--[[        ['vanilla_unicorn'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = nil,
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(103.64, -1292.14, 29.2),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 27.0,
                                ['max'] = 32.0
                            },
        
                            ['points'] = {
                                vector2(119.42, -1299.34),
                                vector2(116.07, -1294.06),
                                vector2(114.62, -1292.96),
                                vector2(104.46, -1299.08),
                                vector2(97.68, -1287.27),
                                vector2(107.61, -1281.02),
                                vector2(119.01, -1279.61),
                                vector2(125.75, -1277.27),
                                vector2(128.81, -1276.93),
                                vector2(134.08, -1287.12),
                                vector2(130.99, -1289.47),
                                vector2(132.76, -1292.06),
                                vector2(134.37, -1294.44),
                                vector2(128.49, -1298.07),
                                vector2(124.62, -1300.01),
                                vector2(122.72, -1297.48)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = {
                'LOS_SANTOS_VANILLA_UNICORN_01_STAGE',
                'LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',
                'LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM'
            },

            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(122.83245849609, -1282.1744384766, 30.500564575195),
                    ['rotation'] = nil,
                    ['heading'] = 209.32180786133,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.85863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 31.71610946655)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.79130554199, -1291.6781005859, 32.583999633789),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(108.38147735596, -1296.1878662109, 32.080726623535),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(110.11848449707, -1295.0183105469, 32.080333709717),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(102.0936050415, -1285.4376220703, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.02025604248, -1284.3253173828, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(98.421371459961, -1287.4619140625, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 76.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(104.74859619141, -1298.3879394531, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 165.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(105.01, -1289.6500244141, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(106.60453033447, -1292.4583740234, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = true,
                    ['position'] = vector3(103.99552154541, -1296.3807373047, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 130.0,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = true,
                    ['position'] = vector3(100.32069396973, -1289.9753417969, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 115.0,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },]]
        ['praca'] = {
            ['enabled'] = true,
            ["permission"] = "player.som",
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(174.48,-924.87,30.68),
                ['height'] = nil,

                ['polygons']= nil,
            },

            ['disableEmitters'] = nil,

            ['scaleform'] = nil,

            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
            },

            ['monitors'] = nil,

            ['screens'] = nil,

            ['spotlights'] = nil,

            ['smokers'] = nil,
            ['sparklers'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(186.86,-916.18,30.68),
                    ['rotation'] = nil,
                    ['heading'] = 341.61,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(173.75,-911.47,30.68),
                    ['rotation'] = nil,
                    ['heading'] = 338.37,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },

        -- Beach Bar
        -- If you have the Cayo Perico island in your server and you want the beach bar setup, enable it below.

        -- ['beach_bar'] = {
        ['MansionRooftop'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 150.0,
                ['center'] = vector3(-817.06,-2173.84,101.96),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['marimonstore_rooftop_telao_01'] = 'telao_marimonstore',
            },

            ['monitors'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-817.06,-2173.84,101.96),
                    ['rotation'] = nil,
                    ['heading'] = nil,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },
            },

            ['screens'] = {
                {
                    ['hash'] = 'marimonstore_rooftop_telao_01',
                    ['position'] = vector3(-812.714844, -2177.10034, 103.355568),
                    ['rotation'] = nil,
                    ['heading'] = 45.00,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-812.714844, -2177.10034, 98.5165558)
                    },
                },
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-822.3658, -2177.61963, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-839.897644, -2160.088, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-831.8286, -2168.157, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },
            },
            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-834.2698, -2157.7688, 100.6735),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['color'] = {242, 223, 7}
                },
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-820.1248, -2171.91382, 100.6735),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['color'] = {242, 7, 7}
                },
            },
            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-818.2992, -2173.627, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-810.3213, -2165.649, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-827.5619, -2148.40845, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-835.541, -2156.3877, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
            },
        },
        --             ['heading'] = 2.99,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         }
        --     }
        -- },

        -- -- Gabz's Vanilla Unicorn (https://www.youtube.com/watch?v=o9UV9tdLU30)
        -- -- If you have this interior enable it below, and disable the default "vanilla" entry.

        -- ['gabz_vanilla_unicorn'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = false,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 50,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,

        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },

        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 128.0,
        --         ['center'] = vector3(103.64, -1292.14, 29.2),
        --         ['height'] = nil,

        --         ['polygons'] = {
        --             ['applyLowPassFilterOutside'] = true,
        --             ['invertLowPassApplication'] = false,
        --             ['hideReplacersOutside'] = true,

        --             ['entries'] = {
        --                 {
        --                     ['height'] = {
        --                         ['min'] = 27.0,
        --                         ['max'] = 32.0
        --                     },
        
        --                     ['points'] = {
        --                         vector2(119.42, -1299.34),
        --                         vector2(116.07, -1294.06),
        --                         vector2(114.62, -1292.96),
        --                         vector2(104.46, -1299.08),
        --                         vector2(97.68, -1287.27),
        --                         vector2(107.61, -1281.02),
        --                         vector2(119.01, -1279.61),
        --                         vector2(125.75, -1277.27),
        --                         vector2(128.81, -1276.93),
        --                         vector2(134.08, -1287.12),
        --                         vector2(130.99, -1289.47),
        --                         vector2(132.76, -1292.06),
        --                         vector2(134.37, -1294.44),
        --                         vector2(128.49, -1298.07),
        --                         vector2(124.62, -1300.01),
        --                         vector2(122.72, -1297.48)
        --                     }
        --                 }
        --             }
        --         }
        --     },

--[[
            ['disableEmitters'] = {
                'LOS_SANTOS_VANILLA_UNICORN_01_STAGE',
                'LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',
                'LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM'
            },

            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(122.83245849609, -1282.1744384766, 30.500564575195),
                    ['rotation'] = nil,
                    ['heading'] = 209.32180786133,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.85863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 32.01610946655)
                    },
                },

                {
                    ['hash'] = 'prop_strip_pole_01',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.45863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 31.61610946655)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.79130554199, -1291.6781005859, 32.583999633789),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(108.38147735596, -1296.1878662109, 32.080726623535),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(110.11848449707, -1295.0183105469, 32.080333709717),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(102.0936050415, -1285.4376220703, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.02025604248, -1284.3253173828, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(103.99552154541, -1296.3807373047, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 141.53,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(100.32069396973, -1289.9753417969, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 97.29,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(105.01, -1289.6500244141, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(106.60453033447, -1292.4583740234, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(98.9, -1287.81, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 98.22,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(104.78, -1297.79, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 129.74,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },
--]]

        -- Breze's Medusa Nightclub (https://www.youtube.com/watch?v=WkSDHNS9UDY)
        -- If you have this interior enable it below.

--         ['breze_medusa_nightclub'] = {
--             ['enabled'] = false,
--             ['autoAdjustTime'] = false,
--             ['idleWallpaperUrl'] = nil,
--             ['maxVolumePercent'] = 50,
--             ['smokeFxMultiplier'] = 3,
--             ['smokeTimeoutMs'] = 5000,
--             ['sparklerFxMultiplier'] = 1,
--             ['sparklerTimeoutMs'] = 1500,
--             ['delayBetweenSmokeChainMs'] = 1500,
--             ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
--             ['featureDelayWithControllerInterfaceClosedMs'] = 500,
-- 
--             ['bass'] = {
--                 ['smoke'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = false
--                 },
-- 
--                 ['sparklers'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = false
--                 }
--             },
-- 
--             ['area'] = {
--                 ['range'] = 128.0,
--                 ['center'] = vector3(745.37, -554.77, 28.65),
--                 ['height'] = nil,
-- 
--                 ['polygons'] = {
--                     ['applyLowPassFilterOutside'] = true,
--                     ['invertLowPassApplication'] = false,
--                     ['hideReplacersOutside'] = true,
-- 
--                     ['entries'] = {
--                         {
--                             ['height'] = {
--                                 ['min'] = 26.0,
--                                 ['max'] = 32.0
--                             },
--         
--                             ['points'] = {
--                                 vector2(757.49, -535.57),
--                                 vector2(749.46, -535.36),
--                                 vector2(746.87, -536.82),
--                                 vector2(729.46, -572.98),
--                                 vector2(758.1, -586.28),
--                                 vector2(757.7, -545.72)
--                             }
--                         },
--                         
--                         {
--                             ['height'] = {
--                                 ['min'] = 32.0,
--                                 ['max'] = 36.0
--                             },
--         
--                             ['points'] = {
--                                 vector2(754.14, -569.86),
--                                 vector2(754.17, -574.41),
--                                 vector2(751.19, -577.98),
--                                 vector2(746.51, -578.33),
--                                 vector2(742.82, -575.05),
--                                 vector2(743.16, -570.34),
--                                 vector2(746.01, -567.21),
--                                 vector2(750.68, -567.06)
--                             }
--                         }
--                     }
--                 }
--             },
-- 
--             ['disableEmitters'] = nil,
--             ['scaleform'] = nil,
-- 
--             ['replacers'] = {
--                 ['ba_prop_battle_club_screen'] = 'script_rt_club_tv'
--             },
-- 
--             ['monitors'] = {
--                 {
--                     ['hash'] = 'ba_prop_battle_club_screen_02',
--                     ['position'] = vector3(738.32971191406, -554.88000488281, 30.901714324951),
--                     ['rotation'] = nil,
--                     ['heading'] = 64.16,
--                     ['lodDistance'] = nil
--                 }
--             },
-- 
--             ['screens'] = nil,
-- 
--             ['spotlights'] = {
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(738.67272949219, -555.03344726562, 32.444766998291),
--                     ['rotation'] = nil,
--                     ['heading'] = 71.46,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 1, 1}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(756.40258789062, -548.21002197266, 32.436893463135),
--                     ['rotation'] = nil,
--                     ['heading'] = 271.3,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 0}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(756.66101074219, -561.20684814453, 32.434928894043),
--                     ['rotation'] = nil,
--                     ['heading'] = 271.3,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 5, 190}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(747.39, -561.07, 32.44),
--                     ['rotation'] = nil,
--                     ['heading'] = 96.2,
--                     ['lodDistance'] = nil,
--                     ['color'] = {3, 83, 255}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(747.38, -548.41, 32.44),
--                     ['rotation'] = nil,
--                     ['heading'] = 85.57,
--                     ['lodDistance'] = nil,
--                     ['color'] = {15, 3, 255}
--                 }
--             },
-- 
--             ['smokers'] = {
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(754.189453125, -558.76391601562, 27.639999389648),
--                     ['rotation'] = nil,
--                     ['heading'] = 299.15716552734,
--                     ['lodDistance'] = nil,
--                     ['color'] = {0, 255, 0}
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(754.10021972656, -550.59643554688, 27.639999389648),
--                     ['rotation'] = nil,
--                     ['heading'] = 238.93334960938,
--                     ['lodDistance'] = nil,
--                     ['color'] = {0, 255, 0}
--                 }
--             },
-- 
--             ['sparklers'] = {
--                 {
--                     ['hash'] = 'prop_cs_pour_tube',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(753.32, -551.51, 27.647521972656),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {0, 255, 0}
--                 },
-- 
--                 {
--                     ['hash'] = 'prop_cs_pour_tube',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(753.32, -557.85, 27.647521972656),
--                     ['rotation'] = nil,
--                     ['heading'] = 238.93334960938,
--                     ['lodDistance'] = nil,
--                     ['color'] = {0, 255, 0}
--                 }
--             },
-- 
--             ['speakers'] = {
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_large',
--                     ['visible'] = false,
--                     ['position'] = vector3(754.42, -557.88, 27.6),
--                     ['rotation'] = nil,
--                     ['heading'] = 274.2,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.7),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 32.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.25,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 0.5,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 15
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_large',
--                     ['visible'] = false,
--                     ['position'] = vector3(754.26, -551.53, 27.6),
--                     ['rotation'] = nil,
--                     ['heading'] = 272.5,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.7),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 32.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.25,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 0.5,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 15
--                 }
--             }
--         },

        -- UncleJust's Vinewood Nightclub (https://www.youtube.com/watch?v=bwcH_KODvPI)
        -- If you have this interior enable it below.

--         ['unclejust_vinewood_nightclub'] = {
--             ['enabled'] = false,
--             ['autoAdjustTime'] = false,
--             ['idleWallpaperUrl'] = nil,
--             ['maxVolumePercent'] = 50,
--             ['smokeFxMultiplier'] = 3,
--             ['smokeTimeoutMs'] = 5000,
--             ['sparklerFxMultiplier'] = 1,
--             ['sparklerTimeoutMs'] = 1500,
--             ['delayBetweenSmokeChainMs'] = 1500,
--             ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
--             ['featureDelayWithControllerInterfaceClosedMs'] = 500,
-- 
--             ['bass'] = {
--                 ['smoke'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = true
--                 },
-- 
--                 ['sparklers'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = true
--                 }
--             },
-- 
--             ['area'] = {
--                 ['range'] = 36.0,
--                 ['center'] = vector3(372.44, 276.53, 91.19),
--                 ['height'] = nil,
-- 
--                 ['polygons'] = {
--                     ['applyLowPassFilterOutside'] = true,
--                     ['invertLowPassApplication'] = false,
--                     ['hideReplacersOutside'] = true,
-- 
--                     ['entries'] = {
--                         {
--                             ['height'] = {
--                                 ['min'] = 90.0,
--                                 ['max'] = 93.0
--                             },
-- 
--                             ['points'] = {
--                                 vector2(346.24, 276.08),
--                                 vector2(349.61, 289.9),
--                                 vector2(381.23, 281.63),
--                                 vector2(377.56, 267.11),
--                                 vector2(350.76, 270.37),
--                                 vector2(350.36, 274.86)
--                             }
--                         },
-- 
--                         {
--                             ['height'] = {
--                                 ['min'] = 93.0,
--                                 ['max'] = 96.0
--                             },
-- 
--                             ['points'] = {
--                                 vector2(353.52, 272.84),
--                                 vector2(355.83, 278.45),
--                                 vector2(354.04, 279.21),
--                                 vector2(357.58, 288.01),
--                                 vector2(381.36, 281.72),
--                                 vector2(377.67, 267.05),
--                                 vector2(372.51, 268.12),
--                                 vector2(371.01, 262.22),
--                                 vector2(361.28, 264.88),
--                                 vector2(362.92, 270.56)
--                             }
--                         }
--                     }
--                 }
--             },
-- 
--             ['disableEmitters'] = nil,
--             ['scaleform'] = nil,
-- 
--             ['replacers'] = {
--                 ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
--                 ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
--             },
-- 
--             ['monitors'] = nil,
--             ['screens'] = nil,
-- 
--             ['spotlights'] = {
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(363.42559814453, 276.72326660156, 92.779304504395),
--                     ['rotation'] = nil,
--                     ['heading'] = 76.13468170166,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 5, 190}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(364.55303955078, 280.58059692383, 92.794158935547),
--                     ['rotation'] = nil,
--                     ['heading'] = 75.477386474609,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 0}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(365.38845825195, 273.95819091797, 92.779861450195),
--                     ['rotation'] = nil,
--                     ['heading'] = 158.18849182129,
--                     ['lodDistance'] = nil,
--                     ['color'] = {3, 83, 255}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(369.53955078125, 272.80334472656, 92.794219970703),
--                     ['rotation'] = nil,
--                     ['heading'] = 148.77075195312,
--                     ['lodDistance'] = nil,
--                     ['color'] = {15, 3, 255}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(373.92681884766, 276.08227539062, 93.283363342285),
--                     ['rotation'] = nil,
--                     ['heading'] = 250.84906005859,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 1, 1}
--                 }
--             },
-- 
--             ['smokers'] = {
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = false,
-- 
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(361.63854980469, 275.40472412109, 90.170631408691),
--                     ['rotation'] = nil,
--                     ['heading'] = 88.489730834961,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 215, 0}
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = false,
-- 
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(367.10723876953, 282.82067871094, 90.174537658691),
--                     ['rotation'] = nil,
--                     ['heading'] = 2.2324018478394,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 215, 0}
--                 }
--             },
-- 
--             ['sparklers'] = {
--                 {
--                     ['hash'] = 'prop_cs_pour_tube',
--                     ['visible'] = true,
-- 
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(373.81, 279.13, 90.178985595703),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 215, 0}
--                 },
-- 
--                 {
--                     ['hash'] = 'prop_cs_pour_tube',
--                     ['visible'] = true,
-- 
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(372.41, 274.05, 90.178985595703),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 215, 0}
--                 }
--             },
-- 
--             ['speakers'] = {
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_small',
--                     ['visible'] = false,
--                     ['position'] = vector3(374.18133544922, 279.08819580078, 90.181503295898),
--                     ['rotation'] = nil,
--                     ['heading'] = 263.55068969727,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.0),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 28.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.25,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 0.5,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 0
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_small',
--                     ['visible'] = false,
--                     ['position'] = vector3(372.68405151367, 273.84048461914, 90.180465698242),
--                     ['rotation'] = nil,
--                     ['heading'] = 257.89999389648,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.0),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 28.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.25,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 0.5,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 0
--                 }
--             }
--         },

        -- UncleJust's Vinewood Cinema (https://www.youtube.com/watch?v=ozpJeC7wv7k)
        -- If you have this interior enable it below.

--         ['unclejust_vinewood_cinema'] = {
--             ['enabled'] = false,
--             ['autoAdjustTime'] = true,
--             ['idleWallpaperUrl'] = nil,
--             ['maxVolumePercent'] = 50,
--             ['smokeFxMultiplier'] = 3,
--             ['smokeTimeoutMs'] = 5000,
--             ['sparklerFxMultiplier'] = 1,
--             ['sparklerTimeoutMs'] = 1500,
--             ['delayBetweenSmokeChainMs'] = 1500,
--             ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
--             ['featureDelayWithControllerInterfaceClosedMs'] = 500,
-- 
--             ['bass'] = nil,
-- 
--             ['area'] = {
--                 ['range'] = 36.0,
--                 ['center'] = vector3(339.75, 193.22, 103.01),
--                 ['height'] = nil,
-- 
--                 ['polygons'] = {
--                     ['applyLowPassFilterOutside'] = true,
--                     ['invertLowPassApplication'] = false,
--                     ['hideReplacersOutside'] = true,
-- 
--                     ['entries'] = {
--                         {
--                             ['height'] = {
--                                 ['min'] = 98.0,
--                                 ['max'] = 118.0
--                             },
--         
--                             ['points'] = {
--                                 vector2(326.45, 195.36),
--                                 vector2(338.11, 230.24),
--                                 vector2(362.55, 220.3),
--                                 vector2(350.45, 187.15),
--                             }
--                         }
--                     }
--                 }
--             },
-- 
--             ['disableEmitters'] = nil,
--             ['scaleform'] = nil,
-- 
--             ['replacers'] = {
--                 ['v_ilev_cin_screen'] = 'script_rt_cinscreen'
--             },
-- 
--             ['monitors'] = nil,
--             ['screens'] = nil,
--             ['spotlights'] = nil,
--             ['smokers'] = nil,
--             ['sparklers'] = nil,
-- 
--             ['speakers'] = {
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_small',
--                     ['visible'] = false,
--                     ['position'] = vector3(331.96, 195.93, 102.0),
--                     ['rotation'] = nil,
--                     ['heading'] = 154.93,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.4),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 28.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.5,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 1.0,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 90
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_battle_club_speaker_small',
--                     ['visible'] = false,
--                     ['position'] = vector3(346.34, 190.79, 102.0),
--                     ['rotation'] = nil,
--                     ['heading'] = 177.34,
--                     ['lodDistance'] = nil,
--                     ['soundOffset'] = vector3(0.0, 0.0, 1.4),
--                     ['directionOffset'] = nil,
--                     ['maxDistance'] = 28.0,
--                     ['refDistance'] = 24.0,
--                     ['rolloffFactor'] = 1.5,
--                     ['coneInnerAngle'] = 90,
--                     ['coneOuterAngle'] = 180,
--                     ['coneOuterGain'] = 1.0,
--                     ['fadeDurationMs'] = 250,
--                     ['volumeMultiplier'] = 1.0,
--                     ['lowPassGainReductionPercent'] = 90
--                 }
--             }
--         },

        -- Fiv3Devs' Asgard Beach Disco Club (https://www.youtube.com/watch?v=E3y30z6JAE8)
        -- If you have this interior enable it below.

--         ['fiv3devs_asgard'] = {
--             ['enabled'] = false,
--             ['autoAdjustTime'] = false,
--             ['idleWallpaperUrl'] = nil,
--             ['maxVolumePercent'] = 50,
--             ['smokeFxMultiplier'] = 3,
--             ['smokeTimeoutMs'] = 5000,
--             ['sparklerFxMultiplier'] = 1,
--             ['sparklerTimeoutMs'] = 1500,
--             ['delayBetweenSmokeChainMs'] = 1500,
--             ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
--             ['featureDelayWithControllerInterfaceClosedMs'] = 500,
-- 
--             ['bass'] = {
--                 ['smoke'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = true
--                 },
-- 
--                 ['sparklers'] = {
--                     ['cooldownMs'] = 30000,
--                     ['colorWithDynamicSpotlights'] = true
--                 }
--             },
-- 
--             ['area'] = {
--                 ['range'] = 128.0,
--                 ['center'] = vector3(-1733.92, -822.03, 10.24),
--                 ['height'] = nil,
--                 ['polygons'] = nil
--             },
-- 
--             ['disableEmitters'] = nil,
--             ['scaleform'] = nil,
-- 			
-- 			['replacers'] = {
--                 ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
-- 				['prop_tv_flat_01'] = 'script_rt_tvscreen'
--             },
-- 
--             ['monitors'] = {
--                 {
--                     ['hash'] = 'prop_tv_flat_01',
--                     ['position'] = vector3(-1701.12, -790.2, 15.17),
--                     ['rotation'] = nil,
--                     ['heading'] = 319.71,
--                     ['lodDistance'] = 64
--                 },
-- 
--                 {
--                     ['hash'] = '5d_asgard_schermopalco_hall',
--                     ['interior'] = true,
--                     ['position'] = vector3(-1743.21, -836.171, 12.43873),
--                     ['rotation'] = nil,
--                     ['heading'] = 49.0,
--                     ['lodDistance'] = nil
--                 }
--             },
-- 
--             ['screens'] = nil,
-- 
--             ['spotlights'] = {
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1746.54300000, -831.39490000, 15.25240000),
--                     ['rotation'] = vector3(0.0, 0.0, 139.0),
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {15, 3, 255}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1745.83700000, -832.00920000, 15.25240000),
--                     ['rotation'] = vector3(0.0, 0.0, 120.0),
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 0}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1745.05900000, -832.68550000, 15.25240000),
--                     ['rotation'] = vector3(35.0, 0.0, 190.0),
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 1, 1}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1740.03600000, -837.05960000, 15.25240000),
--                     ['rotation'] = vector3(30.0, 0.0, 40.0),
--                     ['heading'] = 52.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 1, 1}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1739.25800000, -837.73610000, 15.25240000),
--                     ['rotation'] = vector3(0.0, 0.0, 160.0),
--                     ['heading'] = 118.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {3, 83, 255}
--                 },
-- 
--                 {
--                     ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
--                     ['hash'] = 'cs_prop_hall_spotlight',
--                     ['position'] = vector3(-1738.37200000, -838.50680000, 15.25240000),
--                     ['rotation'] = vector3(0.0, 0.0, 139.0),
--                     ['heading'] = 270.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 5, 190}
--                 }
--             },
-- 
--             ['smokers'] = {
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(-1743.154, -831.4737, 10.05084),
--                     ['rotation'] = nil,
--                     ['heading'] = 139.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 
--                 {
--                     ['hash'] = 'ba_prop_club_smoke_machine',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ba_club',
--                         ['effect'] = 'scr_ba_club_smoke_machine',
--                     },
-- 
--                     ['position'] = vector3(-1738.71, -835.3363, 10.05084),
--                     ['rotation'] = nil,
--                     ['heading'] = 139.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 }
--             },
-- 
--             ['sparklers'] = {
--                 {
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1742.3, -841.08, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 
--                 {
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1748.5, -835.87, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 				
-- 				{
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1749.44, -835.1, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 				
-- 				{
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1750.39, -834.22, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 
-- 				{
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1741.26, -842.04, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 },
-- 
-- 				{
--                     ['hash'] = 'bkr_prop_coke_tube_03',
--                     ['visible'] = true,
--     
--                     ['fx'] = {
--                         ['library'] = 'scr_ih_club',
--                         ['effect'] = 'scr_ih_club_sparkler',
--                     },
-- 
--                     ['position'] = vector3(-1740.15, -843.05, 10.0535641),
--                     ['rotation'] = nil,
--                     ['heading'] = 0.0,
--                     ['lodDistance'] = nil,
--                     ['color'] = {255, 255, 255}
--                 }
--             },
-- 
-- 			['speakers'] = {
-- 				{
--                     ['hash'] = 'ba_prop_battle_club_speaker_array',
--                     ['visible'] = true,
--                     ['position'] = vector3(-1702.556, -791.5062, 13.56454),
--                     ['heading'] = 0.0,
--                     ['soundOffset'] = vector3(0.0, 0.0, 0.5),
--                     ['maxDistance'] = 16.0,
--                     ['refDistance'] = 8.0
--                 },
-- 
-- 				{
--                     ['hash'] = 'sf_prop_sf_speaker_stand_01a',
--                     ['visible'] = true,
--                     ['position'] = vector3(-1738.64, -842.54, 10.05467),
--                     ['heading'] = 186.11,
--                     ['soundOffset'] = vector3(0.0, 0.0, 2.0),
--                     ['maxDistance'] = 48.0,
--                     ['refDistance'] = 24.0,
--                     ['volumeMultiplier'] = 0.75
--                 },
-- 
--                 {
--                     ['hash'] = 'sf_prop_sf_speaker_stand_01a',
--                     ['visible'] = true,
--                     ['position'] = vector3(-1750.09, -832.6, 10.05467),
--                     ['heading'] = 90.58,
--                     ['soundOffset'] = vector3(0.0, 0.0, 2.0),
--                     ['maxDistance'] = 48.0,
--                     ['refDistance'] = 24.0,
--                     ['volumeMultiplier'] = 0.75
--                 }
--             }
--         },
        
        ['Barragem01'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = true,
            ['idleWallpaperUrl'] = nil,
            --['permission'] = '',
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['area'] = {
                ['range'] = 200.0,
                ['center'] = vector3(1244.83,-186.25,98.79),
                ['height'] = nil,
                ['polygons'] = nil
            },
            ['bass']  =  {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
                
            },
            ['disableEmitters'] = nil,
        
            ['scaleform'] = nil,
            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
            },
            
            ['monitors'] = nil,
            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(1255.91,-230.90,106.00),
                    ['rotation'] = nil,
                    ['heading'] = 95.0,
                    ['lodDistance'] = nil,
        
                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(1252.91,-229.36,108.8)
                    }
                }
            },
            
            ['spotlights'] = {
                    {  --1
                        ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                        ['hash'] = 'cs_prop_hall_spotlight',
                        ['position'] = vector3(1259.71,-222.84,106.9),
                        ['rotation'] = vector3(0, 0.0, 50.00),
                        ['lodDistance'] = nil,
                        ['color'] = {255, 1, 1}
                    },
                    {  ---2
                        ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                        ['hash'] = 'cs_prop_hall_spotlight',
                        ['position'] = vector3(1261.38,-236.42,106.39),
                        ['rotation'] = vector3(0, 0.0, 140.00),
                        ['lodDistance'] = nil,
                        ['color'] = {255, 255, 0}
                    },
                    { ---3  ,195.6
                        ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                        ['hash'] = 'cs_prop_hall_spotlight',
                        ['position'] = vector3(1280.7,-235.1,108.00),
                        ['rotation'] = vector3(0, 0.0, -130.00),
                        ['lodDistance'] = nil,
                        ['color'] = {3, 83, 255}
                    },
                    {  --- 4
                        ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                        ['hash'] = 'cs_prop_hall_spotlight',
                        ['position'] = vector3(1278.73,-221.45,106.68),
                        ['rotation'] = vector3(0,  0.0, -40.00),
                        ['lodDistance'] = nil,
                        ['color'] = {15, 3, 255}
                    },
                    
            },
            ['smokers'] = {
                {--1
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1260.90552, -236.373856, 106.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 223, 7}
                },
                {--2
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1259.71936, -222.816147, 106.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
                {--3
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1275.78333, -235.07222, 106.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
                {--4
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1274.63354, -221.485657, 105.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
                        
            },
            ['sparklers'] = {
                { --1
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(1255.38,-224.3,103.81),
                    ['rotation'] = nil,
                    ['heading'] = 136.07,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                { --2
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(1256.46,-237.42,103.79),
                    ['rotation'] = nil,
                    ['heading'] = 189.93,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                { --3
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(1262.17,-236.24,103.78),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                { --4
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(1260.7,-222.75,103.78),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                
            },
            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1259.71,-223.76,103.78),
                    ['rotation'] = nil,
                    ['heading'] = 167.25,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1260.45,-235.54,103.78),
                    ['rotation'] = nil,
                    ['heading'] = 314.65,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
            },
        },

        ['medellin'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = true,
            ['idleWallpaperUrl'] = nil,
            --['permission'] = '',
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['area'] = {
                ['range'] = 200.0,
                ['center'] = vector3(1421.99,1166.5,114.66),
                ['height'] = nil,
                ['polygons'] = nil
            },
            ['bass']  =  {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

            },
            ['disableEmitters'] = nil,

            ['scaleform'] = nil,
            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
            },

            ['monitors'] = nil,
            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(1421.56,1166.34,116.66),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(1421.56,1166.34,116.66)
                    }
                }
            },

            ['spotlights'] = nil,
            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(1417.42,1165.31,114.66),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 223, 7}
                },
            },
            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1426.12,1159.23,116.62),
                    ['rotation'] = nil,
                    ['heading'] = 136.07,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1426.65,1154.59,116.63),
                    ['rotation'] = nil,
                    ['heading'] = 189.93,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1426.74,1150.55,116.63),
                    ['rotation'] = nil,
                    ['heading'] = 189.93,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },

            },
            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1427.98,1166.83,114.38),
                    ['rotation'] = nil,
                    ['heading'] = 167.25,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1415.1,1166.73,114.33),
                    ['rotation'] = nil,
                    ['heading'] = 314.65,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
            },
        },

        ['CasaDoTremBala'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = true,
            ['idleWallpaperUrl'] = nil,
            --['permission'] = '',
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['area'] = {
                ['range'] = 180.0,
                ['center'] = vector3(-2703.58,1343.94,149.77),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
            },

            ['monitors'] = nil,
            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(-2703.58,1343.94,149.77),
                    ['rotation'] = nil,
                    ['heading'] = 80.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-2703.58,1343.94,149.77)
                    }
                },
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(-2705.2,1332.77,149.77),
                    ['rotation'] = nil,
                    ['heading'] = 80.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-2705.2,1331.90,149.77)
                    }
                }
            },

            ['spotlights'] = nil,
            ['smokers'] = nil,
            ['sparklers'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-2702.3,1350.59,147.97),
                    ['rotation'] = nil,
                    ['heading'] = 270.0,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-2705.56,1326.39,147.72),
                    ['rotation'] = nil,
                    ['heading'] = 270.0,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 3.0,
                    ['lowPassGainReductionPercent'] = 15
                },
            },
        },

        ['FavelaHelipa'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = true,
            ['idleWallpaperUrl'] = nil,
            --['permission'] = 'hall.permissao',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['area'] = {
                ['range'] = 200.0,
                ['center'] = vector3(1207.40015,-926.758545,74.09932),
                ['height'] = nil,
                ['polygons'] = nil
            },
            ['bass']  =  {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
            },
            ['disableEmitters'] = nil,

            ['scaleform'] = nil,
            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
            },

            ['monitors'] = nil,
            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(1207.40015, -926.758545, 74.09932),
                    ['rotation'] = nil,
                    ['heading'] = 70.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(1207.40015, -926.758545, 65.75)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1208.89575, -939.804565, 78.94248),
                    ['rotation'] = vector3(0,  0.0, 40.0),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1217.01465, -917.498047, 78.94248),
                    ['rotation'] = vector3(0,  0.0, 90.0),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1213.00952, -928.502, 78.94248),
                    ['rotation'] = vector3(0,  0.0, 90.0),
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1206.40051, -926.096558, 81.68396),
                    ['rotation'] = vector3(0,  0.0, 90.0),
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1200.877, -941.272339, 81.68396),
                    ['rotation'] = vector3(0,  0.0, 90.0),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(1211.4696, -912.1691, 81.68396),
                    ['rotation'] = vector3(0,  0.0, 40.0),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
            },
            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(1204.02222, -934.857849, 78.74285),
                    ['rotation'] = vector3(0, 0.0, 70),
                    ['heading'] = 70.0,
                    ['color'] = {242, 223, 7}
                },
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(1209.86, -918.818848, 78.74285),
                    ['rotation'] = vector3(0, 0.0, 70),
                    ['heading'] = 70.0,
                    ['color'] = {242, 7, 7}
                },
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(1232.37476, -929.730164, 78.5169754),
                    ['rotation'] = vector3(0, 0.0, -110),
                    ['heading'] = 70.0,
                    ['color'] = {242, 223, 7}
                },
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(1229.01062, -938.973, 78.5169754),
                    ['rotation'] = vector3(0, 0.0, -110),
                    ['heading'] = 70.0,
                    ['color'] = {242, 7, 7}
                },
            },
            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1217.11914, -931.0655, 75.29383),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1217.99414, -928.6614, 75.29383),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1209.87292, -921.466736, 71.17304),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(1205.9198, -932.328, 71.17304),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
            },
            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1230.87354, -934.712463, 79.70929),
                    ['rotation'] = nil,
                    ['heading'] = 141.38,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 2.0,
                    ['lowPassGainReductionPercent'] = 15
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(1212.01733, -927.849365, 74.14488),
                    ['rotation'] = nil,
                    ['heading'] = 141.38,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 80.0,
                    ['refDistance'] = 30.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 2.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            },
        },

        -- ['Favela_ET'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     --['permission'] = '',
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        --     ['idleWallpaperUrl'] = 'fotoaqui',

        --     ['area'] = {
        --         ['range'] = 200.0,
        --         ['center'] = vector3(2411.7,3681.72,60.66),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        --     ['bass']  =  {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
                
        --     },
        --     ['disableEmitters'] = nil,
        
        --     ['scaleform'] = nil,
        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },
            
        --     ['monitors'] = nil,
        --     ['screens'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(2375.68384, 3696.62817, 56.4290428),
        --             ['rotation'] = nil,
        --             ['heading'] = 49.33,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(2375.68384, 3696.62817, 64.3950043)
        --             }
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(2371.57886, 3680.85938, 56.4290428),
        --             ['rotation'] = nil,
        --             ['heading'] = 94.33,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(2371.57886, 3680.85938, 64.3950043)
        --             }
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(2390.65454, 3703.12573, 56.4290428),
        --             ['rotation'] = nil,
        --             ['heading'] = 4.33,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(2390.65454, 3703.12573, 64.3950043)
        --             }
        --         },


        --         {
        --             ['hash'] = 'prop_huge_display_02',
        --             ['position'] = vector3(2459.12427, 3709.93359, 58.6689148),
        --             ['rotation'] = nil,
        --             ['heading'] = -40.67,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(2459.12427, 3709.93359, 64.36277)
        --             }
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_02',
        --             ['position'] = vector3(2438.89331, 3686.99878, 58.6689148),
        --             ['rotation'] = nil,
        --             ['heading'] = 139.33,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(2438.89331, 3686.99878, 64.36277)
        --             }
        --         },
        --     },
            
        --     ['spotlights'] = {
        --             {  --1
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2372.13623, 3689.59766, 68.54334),
        --                 ['rotation'] = vector3(0, 0.0, 94.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 1, 1}
        --             },
        --             {  ---2
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2373.437, 3672.439, 68.54334),
        --                 ['rotation'] = vector3(0, 0.0, 94.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 255, 0}
        --             },
        --             { ---3
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2385.2124, 3670.24365, 68.54334),
        --                 ['rotation'] = vector3(0, 0.0, 4.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {3, 83, 255}
        --             },
        --             {  --- 4
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2382.20117, 3701.21045, 68.54334),
        --                 ['rotation'] = vector3(0,  0.0, 4.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {15, 3, 255}
        --             },
        --             {  --- 5
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2399.44556, 3702.51758, 68.54334),
        --                 ['rotation'] = vector3(0,  0.0, 4.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {15, 3, 255}
        --             },
        --             {  --- 6
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(2403.1228, 3691.08252, 68.54334),
        --                 ['rotation'] = vector3(0,  0.0, 94.33),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {15, 3, 255}
        --             },
                    
        --     },
        --     ['smokers'] = {
        --         {--1
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(2382.14551, 3701.78271, 61.4528236),
        --             ['rotation'] = vector3(0, 0.0, 4.33),
        --             ['color'] = {242, 223, 7}
        --         },
        --         {--2
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(2371.63525, 3689.54614, 61.4528236),
        --             ['rotation'] = vector3(0, 0.0, 94.33),
        --             ['color'] = {242, 7, 7}
        --         },
        --         {--3
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(2372.93677, 3672.37476, 61.4528236),
        --             ['rotation'] = vector3(0, 0.0, 94.33),
        --             ['color'] = {242, 7, 7}
        --         },
        --         {--4
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(2399.36646, 3703.08813, 61.4528236),
        --             ['rotation'] = vector3(0, 0.0, 4.33),
        --             ['color'] = {242, 7, 7}
        --         },
                        
        --     },
        --     ['sparklers'] = {
        --         { --1
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(2380.739, 3693.89551, 61.32843),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 7, 7}
        --         },
        --         { --2
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(2379.09058, 3691.92358, 61.32843),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --         { --3
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(2377.45825, 3688.388, 61.3197441),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --         { --4
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(2384.109, 3696.12964, 61.3197441),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
                
        --     },
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(2378.026, 3694.499, 64.50769),
        --             ['rotation'] = nil,
        --             ['heading'] = 45.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 80.0,
        --             ['refDistance'] = 30.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 2.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(2453.6604, 3694.84985, 63.4774857),
        --             ['rotation'] = nil,
        --             ['heading'] = -130.0,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 80.0,
        --             ['refDistance'] = 30.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 2.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     },
        -- },

        -- ['FavelaOBS'] = {
        --     ['enabled'] = true,
        --     -- ['permission'] = 'hall.permissao',
        --     ['autoAdjustTime'] = false,
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        --     ['idleWallpaperUrl'] = nil,
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },

        --         ['sparklers'] = {
        --             ['cooldownMs'] = 1000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 200.0,
        --         ['center'] = vector3(-491.34,1506.61,392.89),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['disableEmitters'] = nil,

        --     ['scaleform'] = nil,
        --     ['replacers'] = {
        --         ['marimonstore_boateilegal_telao'] = 'script_rt_cinscreen',   
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',         
        --     },
            
        --     ['monitors'] = nil,
        --     ['screens'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(-497.8575, 1491.33, 394.764465),
        --             ['rotation'] = nil,
        --             ['heading'] = 160.05,
        --             ['lodDistance'] = nil,

        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(-497.8575, 1491.33, 381.764465)
        --             }
        --         }
        --     },
        --     ['spotlights'] = {

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-482.983459, 1487.50146, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0, 190.9848078),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
                
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-511.854248, 1498.00952, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0, 130.9848078),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 0}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-503.127625, 1494.83325, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0, 150.9848078),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {3, 83, 255}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-491.5404, 1490.61584, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0, 150.9848078),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {15, 3, 255}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-482.036835, 1516.72668, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0,-20.30),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 5, 190}
        --         },
                
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-473.993683, 1513.79919, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0,-50.30),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-493.366638, 1520.85034, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0,-20.30),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 0}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-502.604462, 1524.21265, 399.213348),
        --             ['rotation'] = vector3(0.0, 0.0,25.30),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {3, 83, 255}
        --         },

                
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(-501.65,1510.34,394.20),
        --             ['rotation'] = nil,
        --             ['heading'] = 249.45,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(-504.09,1503.46,394.20),
        --             ['rotation'] = nil,
        --             ['heading'] = 249.45,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(-502.41,1508.06,395.14),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },

        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(-503.41,1505.28,395.22),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
                
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(-487.62,1488.9,392.89),
        --             ['rotation'] = nil,
        --             ['heading'] = 155.91,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(-507.41,1496.19,392.89),
        --             ['rotation'] = nil,
        --             ['heading'] = 155.91,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(-495.62,1521.88,392.89),
        --             ['rotation'] = nil,
        --             ['heading'] = 345.83,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(-478.03,1515.5,392.89),
        --             ['rotation'] = nil,
        --             ['heading'] = 340.16,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     }
        -- },

        -- ['MarimonStore#03'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 150.0,
        --         ['center'] = vector3(1886.26,4846.46,51.48),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['monitors'] = nil,
        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,

        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },

        --     ['screens'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(1879.76465, 4853.30566, 45.9516869),
        --             ['rotation'] = nil,
        --             ['heading'] = 45.36,
        --             ['lodDistance'] = nil,

        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(1879.76465, 4853.30566, 52.961853)
        --             }
        --         }
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1875.01721, 4847.606, 57.4320374),
        --             ['rotation'] = nil,
        --             ['heading'] = 85.04,
        --             ['lodDistance'] = nil,
        --             ['color'] = {15, 3, 255}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1885.22766, 4857.77832, 57.4595261),
        --             ['rotation'] = nil,
        --             ['heading'] = 357.17,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1899.38611, 4843.62256, 57.449234),
        --             ['rotation'] = nil,
        --             ['heading'] = 255.12,
        --             ['lodDistance'] = nil,
        --             ['color'] = {15, 3, 255}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1889.27112, 4833.54443, 57.45294),
        --             ['rotation'] = nil,
        --             ['heading'] = 181.42,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1894.20068, 4838.518, 57.4344978),
        --             ['rotation'] = nil,
        --             ['heading'] = 45.36,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1897.74475, 4840.291, 50.44063),
        --             ['rotation'] = nil,
        --             ['heading'] = 42.52,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1892.33679, 4834.7793, 50.44063),
        --             ['rotation'] = nil,
        --             ['heading'] = 42.52,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1892.58594, 4835.149, 50.48615),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {245, 0, 0}
        --         },

        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1897.46021, 4840.023, 50.48615),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {255, 255, 0}
        --         },
                
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,

        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1874.88135, 4848.60059, 50.464325),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {0, 255, 0}
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,

        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1884.38745, 4858.107, 50.464325),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {175, 0, 175}
        --         },

        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,

        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1889.84558, 4856.46436, 52.096405),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {0, 255, 0}
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,

        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1896.09778, 4850.2417, 52.096405),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = 150,
        --             ['color'] = {175, 0, 175}
        --         },
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1895.87,4823.71,55.3),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },

        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1908.78,4836.78,55.27),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
                
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1922.84,4850.91,50.72),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1898.33,4875.39,51.48),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1871.07,4848.39,51.48),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     }
        -- },

        -- ["Favela_Ferro_Velho_01"] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(1653.37,-1492.85,116.28),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['replacers'] = {
        --         ['v_ilev_cin_screen'] = 'script_rt_cinscreen',
        --     },

        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,
        --     ['monitors'] = nil,

            
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(1640.48,-1487.16,116.67),
        --             ['rotation'] = nil,
        --             ['heading'] = 246.62,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(1656.52,-1457.45,116.16),
        --             ['rotation'] = nil,
        --             ['heading'] = 187.09,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(1628.38,-1517.3,116.15),
        --             ['rotation'] = nil,
        --             ['heading'] = 294.81,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1644.34106, -1481.082, 115.668777),
        --             ['rotation'] = nil,
        --             ['heading'] = 65.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1638.50708, -1493.593, 115.668777),
        --             ['rotation'] = nil,
        --             ['heading'] = 65.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1645.58374, -1490.716, 115.637032),
        --             ['rotation'] = nil,
        --             ['heading'] = 65.00,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1646.71558, -1488.2887, 115.637032),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1646.452, -1476.88147, 125.047134),
        --             ['rotation'] = nil,
        --             ['heading'] = 35.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1646.452, -1479.32422, 123.419731),
        --             ['rotation'] = nil,
        --             ['heading'] = 35.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1636.93408, -1497.95178, 125.006088),
        --             ['rotation'] = nil,
        --             ['heading'] = 95.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1638.51416, -1496.23779, 123.397377),
        --             ['rotation'] = nil,
        --             ['heading'] = 95.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1634.271, -1502.76343, 123.466995),
        --             ['rotation'] = vec3(34.36, -75.11, 54.09),
        --             ['heading'] = 54.09,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1632.4502, -1506.35938, 124.176216),
        --             ['rotation'] = vec3(34.36, -75.11, 54.09),
        --             ['heading'] = 54.09,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1630.685, -1509.80566, 124.890572),
        --             ['rotation'] = vec3(34.36, -75.11, 54.09),
        --             ['heading'] = 54.09,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1649.11108, -1471.47375, 123.2981),
        --             ['rotation'] = vec3(23.15, 62.87, 71.01),
        --             ['heading'] = 71.01,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 1, 1 }
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1650.3158, -1467.64587, 124.03405),
        --             ['rotation'] = vec3(23.15, 62.87, 71.01),
        --             ['heading'] = 71.01,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 1, 1 }
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vec3(1652.05664, -1464.21912, 124.733719),
        --             ['rotation'] = vec3(23.15, 62.87, 71.01),
        --             ['heading'] = 71.01,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 1, 1 }
        --         },
        --     },
        -- },

        -- ['boate_ilegal'] = {
        --     ['enabled'] = true,
        --     --['permission'] = 'hall.permissao',
        --     ['autoAdjustTime'] = false,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        --     ['idleWallpaperUrl'] = 'https://cdn.detroitcity.com.br/Imagens/allin.gif',
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },

        --         ['sparklers'] = {
        --             ['cooldownMs'] = 1000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(1018.58,-2308.45,31.24),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['disableEmitters'] = nil,

        --     ['scaleform'] = nil,
        --     ['replacers'] = {
        --         ['marimonstore_boateilegal_telao'] = 'script_rt_cinscreen',   
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',         
        --     },
            
        --     ['monitors'] = nil,
        --     ['screens'] = nil,
        --     ['spotlights'] = {

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1023.23779, -2320.23022, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, -95.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
                
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1025.083, -2299.1394, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, -95.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 0}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1012.64337, -2298.051, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, 85.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {3, 83, 255}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1010.83514, -2318.719, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, 85.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {15, 3, 255}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1009.14435, -2338.04517, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, 175.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 5, 190}
        --         },
        --         --
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1021.43359, -2339.12036, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, 175.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1025.988, -2287.06421, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, -5.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 0}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1013.99524, -2286.015, 38.36082),
        --             ['rotation'] = vector3(0.0, 0.0, -5.00),
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['color'] = {3, 83, 255}
        --         },

                
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1004.76,-2288.21,30.24),
        --             ['rotation'] = nil,
        --             ['heading'] = 270,
        --             ['lodDistance'] = nil,
        --             ['color'] = {0, 0, 255}
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1003.57,-2301.91,30.24),
        --             ['rotation'] = nil,
        --             ['heading'] = 270,
        --             ['lodDistance'] = nil,
        --             ['color'] = {0, 0, 255}
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1002.41,-2315.11,30.24),
        --             ['rotation'] = nil,
        --             ['heading'] = 270,
        --             ['lodDistance'] = nil,
        --             ['color'] ={0, 0, 255}
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = false,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1001.24,-2328.6,30.24),
        --             ['rotation'] = nil,
        --             ['heading'] = 270,
        --             ['lodDistance'] = nil,
        --             ['color'] = {0, 0, 255}
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1017.276, -2292.63672, 31.3093948),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {175, 0, 175}
        --         },

        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1022.71124, -2293.1123, 31.3093948),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {175, 0, 175}
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1020.51215, -2292.987, 31.3093948),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {175, 0, 175}
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1019.428, -2292.892, 31.3093948),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {175, 0, 175}
        --         },
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1009.08038, -2286.175, 36.7705841),
        --             ['rotation'] = nil,
        --             ['heading'] = 170.08,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1032.36621, -2288.18213, 36.7705841),
        --             ['rotation'] = nil,
        --             ['heading'] = 170.08,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(998.0993, -2265.921, 35.395813),
        --             ['rotation'] = nil,
        --             ['heading'] = 263.63,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(1005.72638, -2372.98633, 41.86875),
        --             ['rotation'] = nil,
        --             ['heading'] = 354.34,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 76.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     }
        -- },

        -- ["Mansao_Black"] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(-2810.39478,1433.75,103.022957),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },

        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,

        --     ['monitors'] = {
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2832.74023, 1424.05945, 105.353409),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2843.99146, 1431.84167, 105.353409),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil  
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2800.65552, 1460.79907, 103.235275),
        --             ['rotation'] = nil,
        --             ['heading'] = -34.67,
        --             ['lodDistance'] = nil  
        --         },                             
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-2807.45239,1431.546,103.609184),
        --             ['rotation'] = nil,
        --             ['heading'] = 45.36,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-2838.20044,1428.36816,103.609184),
        --             ['rotation'] = nil,
        --             ['heading'] = 325.99,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(-2831.42944,1422.82385,99.95429),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(-2845.57544,1432.6084,99.95429),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(-2836.87329,1427.85742,100.931404),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(-2838.97314,1429.30981,100.931404),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-2832.71826,1424.04529,102.992676),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-2838.38062,1427.96167,102.992676),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-2844.06641,1431.89441,102.992676),
        --             ['rotation'] = nil,
        --             ['heading'] = 145.33,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --     },
        -- },

        -- ['Favela_Deserto_03'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = '',
        --     ['permission'] = 'hall.permissao',
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['area'] = {
        --         ['range'] = 200.0,
        --         ['center'] = vector3(-241.31,3855.16,44.13),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        --     ['bass']  =  {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
                
        --     },
        --     ['disableEmitters'] = nil,
        
        --     ['scaleform'] = nil,
        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },
            
        --     ['monitors'] = nil,
        --     ['screens'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(-253.031082, 3851.099, 46.21018),
        --             ['rotation'] = nil,
        --             ['heading'] = 110.0,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(-253.031082, 3851.099, 38.60052)
        --             }
        --         }
        --     },
            
        --     ['spotlights'] = {
        --             {  --1
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-233.500732, 3840.61133, 48.52204),
        --                 ['rotation'] = vector3(0,  0.0, -160.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 1, 1}
        --             },
        
        --             {  ---2
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-237.05423, 3839.318, 48.52204),
        --                 ['rotation'] = vector3(0,  0.0, -160.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 255, 0}
        --             },
        
        --             { ---3
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-251.606171, 3846.69434, 53.6545067),
        --                 ['rotation'] = vector3(0,  0.0, 110.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {3, 83, 255}
        --             },
        
        --             {  --- 4
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-254.789917, 3855.44165, 53.6545067),
        --                 ['rotation'] = vector3(0,  0.0, 110.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {15, 3, 255}
        --             },
        --             {  --5
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-248.117279, 3837.10864, 50.6045),
        --                 ['rotation'] = vector3(0,  0.0, 155.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 1, 1}
        --             },
        
        --             {  ---6
        --                 ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --                 ['hash'] = 'cs_prop_hall_spotlight',
        --                 ['position'] = vector3(-258.23587, 3864.90942, 50.6045),
        --                 ['rotation'] = vector3(0,  0.0, 65.0),
        --                 ['lodDistance'] = nil,
        --                 ['color'] = {255, 255, 0}
        --             },
        --     },
        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-255.579, 3857.431, 43.1187668),
        --             ['rotation'] = vector3(0, 0.0, 70),
        --             ['heading'] = 110.0,
        --             ['color'] = {242, 223, 7}
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-250.899292, 3844.57349, 43.1187668),
        --             ['rotation'] = vector3(0, 0.0, 70),
        --             ['heading'] = 70.0,
        --             ['color'] = {242, 7, 7}
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-236.893341, 3839.17554, 46.797245),
        --             ['rotation'] = vector3(0, 0.0, -110),
        --             ['heading'] = -160.0,
        --             ['color'] = {242, 223, 7}
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-233.544861, 3840.39429, 46.797245),
        --             ['rotation'] = vector3(0, 0.0, -110),
        --             ['heading'] = -160.0,
        --             ['color'] = {242, 7, 7}
        --         },
                        
        --     },
        --     ['sparklers'] = {
        --         { --1
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-233.87294, 3840.74658, 46.8450928),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 7, 7}
        --         },
        --         { --2
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-236.836609, 3839.668, 46.8450928),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --         { --3
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-250.762558, 3845.35059, 43.1764755),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 7, 7}
        --         },
        --         { --4
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-255.025848, 3857.064, 43.1764755),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
                
        --     },
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-241.31,3855.16,44.13),
        --             ['rotation'] = nil,
        --             ['heading'] = 141.38,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 80.0,
        --             ['refDistance'] = 30.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 2.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     },
        -- },

        -- ['fav_ferrovelho_02'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = 150.0,
        --         ['center'] = vector3(1461.75,-2111.31,75.66),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },

        --     ['monitors'] = nil,
        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,

        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },

        --     ['screens'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(1432.80884, -2135.22681, 70.24522),
        --             ['rotation'] = nil,
        --             ['heading'] = 130.4,
        --             ['lodDistance'] = nil,

        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(1432.80884, -2135.22681, 77.6455841)
        --             }
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(1424.45947, -2117.58374, 70.16563),
        --             ['rotation'] = nil,
        --             ['heading'] = 99.22,
        --             ['lodDistance'] = nil,

        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(1424.45947, -2117.58374, 77.6455841)
        --             }
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(1426.07092, -2098.15479, 70.2556152),
        --             ['rotation'] = nil,
        --             ['heading'] = 70.87,
        --             ['lodDistance'] = nil,

        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(1426.07092, -2098.15479, 77.6455841)
        --             }
        --         },
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1423.49377, -2106.37134, 82.17093),
        --             ['rotation'] = nil,
        --             ['heading'] = 68.04,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1427.37354, -2128.1416, 82.16288),
        --             ['rotation'] = nil,
        --             ['heading'] = 130.4,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1429.48523, -2089.91, 82.17093),
        --             ['rotation'] = nil,
        --             ['heading'] = 34.02,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1438.63525, -2141.55029, 82.17093),
        --             ['rotation'] = nil,
        --             ['heading'] = 147.41,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1426.44958, -2125.268, 88.40281),
        --             ['rotation'] = vector3(-45.00, 0.0, 130.0),
        --             ['heading'] = 116.23,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1423.58386, -2109.11548, 88.42697),
        --             ['rotation'] = vector3(-45.00, 0.0, 50.9),
        --             ['heading'] = 56.7,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },

        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1461.52124, -2142.03833, 88.36392),
        --             ['rotation'] = nil,
        --             ['heading'] = 161.58,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1444.79956, -2144.8833, 88.41077),
        --             ['rotation'] = vector3(-45.00, 0.0, -146.18),
        --             ['heading'] = 56.7,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },


        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1450.55237, -2081.96631, 88.36911),
        --             ['rotation'] = nil,
        --             ['heading'] = 25.52,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(1434.26172, -2084.983, 88.4323349),
        --             ['rotation'] = vector3(-45.00, 0.0, 40.09),
        --             ['heading'] = 22.68,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1425.745, -2124.213, 74.65192),
        --             ['rotation'] = nil,
        --             ['heading'] = 99.22,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1423.33118, -2110.54565, 74.6914),
        --             ['rotation'] = nil,
        --             ['heading'] = 99.22,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1423.80908, -2104.61719, 74.66272),
        --             ['rotation'] = nil,
        --             ['heading'] = 65.2,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1428.53662, -2091.58374, 74.7039642),
        --             ['rotation'] = nil,
        --             ['heading'] = 76.54,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },

        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1437.24927, -2140.31079, 74.65689),
        --             ['rotation'] = nil,
        --             ['heading'] = 130.4,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },

        --             ['position'] = vector3(1428.35669, -2129.6958, 74.7034454),
        --             ['rotation'] = nil,
        --             ['heading'] = 76.54,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1425.25061, -2119.79468, 83.54022),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = {245, 0, 0}
        --         },

        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
    
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },

        --             ['position'] = vector3(1424.16, -2113.599, 83.52604),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = {255, 255, 0}
        --         },
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1457.60181, -2141.86816, 77.79299),
        --             ['rotation'] = vector3(0.89, 0.38, -170.60),
        --             ['heading'] = 189.93,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },

        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1467.73755, -2140.19263, 77.83299),
        --             ['rotation'] = vector3(0.81, 0.38, -170.60),
        --             ['heading'] = 189.93,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
                
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1451.854, -2142.96143, 77.7903061),
        --             ['rotation'] = vector3(0.81, 0.38, -170.60),
        --             ['heading'] = 189.93,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1441.73242, -2144.62744, 77.79299),
        --             ['rotation'] = vector3(0.81, 0.38, -170.60),
        --             ['heading'] = 189.93,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },

        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1444.24854, -2092.973, 77.77509),
        --             ['rotation'] = nil,
        --             ['heading'] = 99.22,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1442.56873, -2082.805, 77.76911),
        --             ['rotation'] = nil,
        --             ['heading'] = 99.22,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1460.24646, -2079.62646, 77.77509),
        --             ['rotation'] = nil,
        --             ['heading'] = 283.47,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'h4_prop_h4_isl_speaker_01a',
        --             ['visible'] = true,
        --             ['position'] = vector3(1461.92676, -2089.77954, 77.7501144),
        --             ['rotation'] = nil,
        --             ['heading'] = 283.47,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },



        --         {
        --             ['hash'] = 'h4_prop_battle_club_speaker_array',
        --             ['visible'] = true,
        --             ['position'] = vector3(1423.63831, -2107.91113, 74.65729),
        --             ['rotation'] = nil,
        --             ['heading'] = 102.05,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_speaker_array',
        --             ['visible'] = true,
        --             ['position'] = vector3(1426.89343, -2126.52515, 74.65729),
        --             ['rotation'] = nil,
        --             ['heading'] = 102.05,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     }
        -- },

        -- ['PierRestaurant'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },
        
        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(-1827.5177, -1192.76306, 14.3434649),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        
        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['h4_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },
        
        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,
        
        --     ['monitors'] = {
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-1824.3645, -1189.00525, 17.7627754),
        --             ['rotation'] = nil,
        --             ['heading'] = -130.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-1830.75049, -1196.61572, 17.7627754),
        --             ['rotation'] = nil,
        --             ['heading'] = -130.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-1866.43408, -1219.9082, 16.6015987),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-1831.61133, -1249.12793, 16.6015987),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil
        --         },
        --     },
        
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1831.61133, -1249.12793, 16.1486015),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1866.43408, -1219.9082, 15.4660883),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1827.5177, -1192.76306, 15.6110849),
        --             ['rotation'] = nil,
        --             ['heading'] = -130.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --     },
        
        --     ['smokers'] = nil,
        --     ['sparklers'] = nil,
        --     ['spotlights'] = nil,
        -- },

        -- ['FarolV3'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },
        
        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(3030.62939, 5067.68262, 40.35124),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        
        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['h4_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },
        
        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,
        
        --     ['monitors'] = {
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(3029.32983, 5052.829, 40.35124),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'prop_huge_display_01',
        --             ['position'] = vector3(3029.32983, 5052.829, 33.0398026),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil
        --         },
        
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(3037.337, 5059.45166, 42.2538757),
        --             ['rotation'] = nil,
        --             ['heading'] = 85.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(3038.20679, 5069.395, 42.2538757),
        --             ['rotation'] = nil,
        --             ['heading'] = 85.00,
        --             ['lodDistance'] = nil
        --         },
        --     },
        
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(3029.32983, 5052.829, 40.35124),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(3031.468, 5077.26953, 40.35124),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --     },
        
        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(3034.69385, 5052.85352, 37.8356552),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(3024.04175, 5053.78564, 37.8356552),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(3024.24561, 5060.63232, 37.8356552),
        --             ['rotation'] = nil,
        --             ['heading'] = 85.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(3035.39063, 5059.5957, 37.8356552),
        --             ['rotation'] = nil,
        --             ['heading'] = -95.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        --     },
        
        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(3034.69385, 5052.85352, 38.1142273),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(3024.04175, 5053.78564, 38.1142273),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(3024.24561, 5060.63232, 38.1142273),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 255, 255, 0 }
        --         },
        
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(3035.39063, 5059.5957, 38.1142273),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 255, 255, 0 }
        --         },
        --     },
        
        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3029.40723, 5055.125, 43.6691742),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3034.28125, 5054.69873, 42.9604454),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3024.42261, 5055.56152, 42.9604454),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3030.71338, 5070.05566, 43.6691742),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3025.731, 5070.51563, 42.9604454),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(3035.58765, 5069.63, 42.9604454),
        --             ['rotation'] = nil,
        --             ['heading'] = 175.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --     },
        -- },

        -- ['PostoPraia'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = true,
        --     ['idleWallpaperUrl'] = nil,
        --     ['maxVolumePercent'] = 100,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },
        
        --     ['area'] = {
        --         ['range'] = 250.0,
        --         ['center'] = vector3(-2065.90259, -327.658, 17.6143684),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        
        --     ['replacers'] = {
        --         ['big_screens'] = 'script_rt_big_disp',
        --         ['h4_prop_battle_club_screen'] = 'script_rt_club_tv',
        --         ['h4_prop_battle_club_projector'] = 'script_rt_club_projector',
        --     },
        
        --     ['scaleform'] = nil,
        --     ['disableEmitters'] = nil,
        
        --     ['monitors'] = {
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2064.018, -313.458527, 20.79078),
        --             ['rotation'] = nil,
        --             ['heading'] = 174.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2066.92847, -341.148, 20.79078),
        --             ['rotation'] = nil,
        --             ['heading'] = 174.00,
        --             ['lodDistance'] = nil
        --         },
        --         {
        --             ['hash'] = 'h4_prop_battle_club_screen',
        --             ['position'] = vector3(-2064.02539, -313.5253, 20.79078),
        --             ['rotation'] = nil,
        --             ['heading'] = -6.00,
        --             ['lodDistance'] = nil
        --         },
        --     },
        
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1831.61133, -1249.12793, 16.1486015),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1866.43408, -1219.9082, 15.4660883),
        --             ['rotation'] = nil,
        --             ['heading'] = 140.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --         {
        --             ['hash'] = 'xs_propintarena_speakers_01a',
        --             ['visible'] = false,
        --             ['position'] = vector3(-1827.5177, -1192.76306, 15.6110849),
        --             ['rotation'] = nil,
        --             ['heading'] = -130.00,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = vector3(0.0, 0.0, 1.4),
        --             ['directionOffset'] = nil,
        --             ['maxDistance'] = 28.0,
        --             ['refDistance'] = 24.0,
        --             ['rolloffFactor'] = 1.5,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 1.0,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 90
        --         },
        --     },
        
        --     ['smokers'] = {
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-2060.25415, -325.0544, 17.3713913),
        --             ['rotation'] = nil,
        --             ['heading'] = -96.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = { 255, 255, 255 }
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(1295.41663, -733.1043, 68.59081),
        --             ['rotation'] = nil,
        --             ['heading'] = -96.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-2059.65625, -319.363983, 17.3713913),
        --             ['rotation'] = nil,
        --             ['heading'] = -96.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        
        --         {
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-2061.47583, -336.675, 17.3713913),
        --             ['rotation'] = nil,
        --             ['heading'] = -96.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 255}
        --         },
        --     },
        
        --     ['sparklers'] = {
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-2061.78345, -341.549652, 18.2678261),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-2060.74731, -331.69223, 18.2678261),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 245, 0, 0 }
        --         },
        
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-2059.96021, -324.20285, 18.2678261),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 255, 255, 0 }
        --         },
        
        --         {
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-2058.92773, -314.3805, 18.2678261),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = 800,
        --             ['color'] = { 255, 255, 0 }
        --         },
        --     },
        
        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-2059.2, -314.632843, 21.8315544),
        --             ['rotation'] = nil,
        --             ['heading'] = -51.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-2061.796, -341.392181, 21.8315544),
        --             ['rotation'] = nil,
        --             ['heading'] = -146.00,
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         }
        --     },
        -- },

        -- ['MansionRooftop'] = {
        --     ['enabled'] = true,
        --     ['autoAdjustTime'] = false,
        --     ['maxVolumePercent'] = 150,
        --     ['smokeFxMultiplier'] = 3,
        --     ['smokeTimeoutMs'] = 5000,
        --     ['sparklerFxMultiplier'] = 1,
        --     ['sparklerTimeoutMs'] = 1500,
        --     ['delayBetweenSmokeChainMs'] = 1500,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         },
        
        --         ['sparklers'] = {
        --             ['cooldownMs'] = 30000,
        --             ['colorWithDynamicSpotlights'] = true
        --         }
        --     },
        
        --     ['area'] = {
        --         ['range'] = 150.0,
        --         ['center'] = vector3(-817.06,-2173.84,101.96),
        --         ['height'] = nil,
        --         ['polygons'] = nil
        --     },
        
        --     ['disableEmitters'] = nil,
        --     ['scaleform'] = nil,
        
        --     ['replacers'] = {
        --         ['marimonstore_rooftop_telao_01'] = 'telao_marimonstore',
        --     },
        
        --     ['monitors'] = nil,
        
        --     ['speakers'] = {
        --         {
        --             ['hash'] = 'ba_prop_battle_club_speaker_large',
        --             ['visible'] = false,
        --             ['position'] = vector3(-817.06,-2173.84,101.96),
        --             ['rotation'] = nil,
        --             ['heading'] = nil,
        --             ['lodDistance'] = nil,
        --             ['soundOffset'] = nil,
        --             ['distanceOffset'] = nil,
        --             ['maxDistance'] = 32.0,
        --             ['refDistance'] = 16.0,
        --             ['rolloffFactor'] = 1.25,
        --             ['coneInnerAngle'] = 90,
        --             ['coneOuterAngle'] = 180,
        --             ['coneOuterGain'] = 0.5,
        --             ['fadeDurationMs'] = 250,
        --             ['volumeMultiplier'] = 1.0,
        --             ['lowPassGainReductionPercent'] = 15
        --         },
        --     },
        
        --     ['screens'] = {
        --         {
        --             ['hash'] = 'marimonstore_rooftop_telao_01',
        --             ['position'] = vector3(-812.714844, -2177.10034, 103.355568),
        --             ['rotation'] = nil,
        --             ['heading'] = 45.00,
        --             ['lodDistance'] = nil,
        
        --             ['advance'] = {
        --                 ['durationMs'] = 10000,
        --                 ['position'] = vector3(-812.714844, -2177.10034, 98.5165558)
        --             },
        --         },
        --     },
        
        --     ['spotlights'] = {
        --         {  --1
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-822.3658, -2177.61963, 104.588135),
        --             ['rotation'] = vector3(0, 0.0, 135.00),
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 1, 1}
        --         },
        --         {  ---2
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-839.897644, -2160.088, 104.588135),
        --             ['rotation'] = vector3(0, 0.0, 135.00),
        --             ['lodDistance'] = nil,
        --             ['color'] = {255, 255, 0}
        --         },
        --         { ---3
        --             ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
        --             ['hash'] = 'cs_prop_hall_spotlight',
        --             ['position'] = vector3(-831.8286, -2168.157, 104.588135),
        --             ['rotation'] = vector3(0, 0.0, 135.00),
        --             ['lodDistance'] = nil,
        --             ['color'] = {3, 83, 255}
        --         },
                
        --     },
        --     ['smokers'] = {
        --         {--1
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-834.2698, -2157.7688, 100.6735),
        --             ['rotation'] = vector3(0, 0.0, 135.00),
        --             ['color'] = {242, 223, 7}
        --         },
        --         {--2
        --             ['hash'] = 'ba_prop_club_smoke_machine',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ba_club',
        --                 ['effect'] = 'scr_ba_club_smoke_machine',
        --             },
        
        --             ['position'] = vector3(-820.1248, -2171.91382, 100.6735),
        --             ['rotation'] = vector3(0, 0.0, 135.00),
        --             ['color'] = {242, 7, 7}
        --         },
                                    
        --     },
        --     ['sparklers'] = {
        --         { --1
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-818.2992, -2173.627, 101.1168),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 7, 7}
        --         },
        --         { --2
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-810.3213, -2165.649, 101.1168),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --         { --3
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-827.5619, -2148.40845, 101.1168),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --         { --4
        --             ['hash'] = 'prop_cs_pour_tube',
        --             ['visible'] = true,
        
        --             ['fx'] = {
        --                 ['library'] = 'scr_ih_club',
        --                 ['effect'] = 'scr_ih_club_sparkler',
        --             },
        
        --             ['position'] = vector3(-835.541, -2156.3877, 101.1168),
        --             ['rotation'] = nil,
        --             ['heading'] = 0.0,
        --             ['lodDistance'] = nil,
        --             ['color'] = {242, 195, 7}
        --         },
        --     }, 
        -- },

        --[[['Mansao_Rooftop_01'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            --['permission'] = 'dono.permissao',
            ['idleWallpaperUrl'] = nil,
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 150.0,
                ['center'] = vector3(-817.06,-2173.84,101.96),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
            },

            ['monitors'] = nil,

            ['screens'] = nil,

            ['spotlights'] = nil,

            ['smokers'] = nil,
            ['sparklers'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-817.06,-2173.84,101.96),
                    ['rotation'] = nil,
                    ['heading'] = nil,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = nil,
                    ['distanceOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },
            },
            ['screens'] = {
                {
                    ['hash'] = 'marimonstore_rooftop_telao_01',
                    ['position'] = vector3(-812.714844, -2177.10034, 103.355568),
                    ['rotation'] = nil,
                    ['heading'] = 45.00,
                    ['lodDistance'] = nil,
        
                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-812.714844, -2177.10034, 98.5165558)
                    },
                },
            },

            ['spotlights'] = {
                {  --1
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-822.3658, -2177.61963, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },
                {  ---2
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-839.897644, -2160.088, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
                { ---3
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-831.8286, -2168.157, 104.588135),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },
                
            },
            ['smokers'] = {
                {--1
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(-834.2698, -2157.7688, 100.6735),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['color'] = {242, 223, 7}
                },
                {--2
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(-820.1248, -2171.91382, 100.6735),
                    ['rotation'] = vector3(0, 0.0, 135.00),
                    ['color'] = {242, 7, 7}
                },
                                    
            },
            ['sparklers'] = {
                { --1
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(-818.2992, -2173.627, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 7, 7}
                },
                { --2
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(-810.3213, -2165.649, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                { --3
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(-827.5619, -2148.40845, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
                { --4
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },
        
                    ['position'] = vector3(-835.541, -2156.3877, 101.1168),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {242, 195, 7}
                },
            }, 
        }]]
        
        ['BaileFavelaTelao'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = nil,
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 1,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
            },

            ['area'] = {
                ['range'] = 120.0,
                ['center'] = vector3(-1694.66,983.15,177.6),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
            },

            ['monitors'] = nil,

            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(-1694.66,983.15,177.6),
                    ['rotation'] = nil,
                    ['heading'] = 150.00,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-1694.66,983.15,172.76)
                    },
                },
            },

            ['spotlights'] = nil,
            ['smokers'] = nil,
            ['sparklers'] = nil,
            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-1691.95,984.27,177.6),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-1697.37,982.03,177.6),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-1672.36,989.98,177.61),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                }
            }
        },

        

        -- Below you can find a full config entry reference.

        -- ['key'] = {
        --     ['enabled'] = boolean,
        --     ['autoAdjustTime'] = boolean,
        --     ['idleWallpaperUrl'] = string,
        --     ['maxVolumePercent'] = number,
        --     ['smokeFxMultiplier'] = number,
        --     ['smokeTimeoutMs'] = number,
        --     ['sparklerFxMultiplier'] = number,
        --     ['sparklerTimeoutMs'] = number,
        --     ['delayBetweenSmokeChainMs'] = number,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = number,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = number,

        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = number,
        --             ['colorWithDynamicSpotlights'] = boolean
        --         },

        --         ['sparklers'] = {
        --             ['cooldownMs'] = number,
        --             ['colorWithDynamicSpotlights'] = boolean
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = number,
        --         ['center'] = vector3(number, number, number),

        --         ['height'] = {
        --             ['min'] = number,
        --             ['max'] = number
        --         },

        --         ['polygons'] = {
        --             ['applyLowPassFilterOutside'] = boolean,
        --             ['invertLowPassApplication'] = boolean,
        --             ['hideReplacersOutside'] = boolean,

        --             ['entries'] = {
        --                 {
        --                     ['height'] = {
        --                         ['min'] = number,
        --                         ['max'] = number
        --                     },
        
        --                     ['points'] = {
        --                         vector2(number, number),
        --                         ...
        --                     ]
        --                 }
        --             ]
        --         }
        --     },

        --     ['disableEmitters'] = {string, ...},

        --     ['scaleform'] = {
        --         ['solid'] = boolean,
        --         ['flag'] = boolean,
        --         ['position'] = vector3(number, number, number),
        --         ['rotation'] = vector3(number, number, number),
        --         ['scale'] = vector3(number, number, number)
        --     },

        --     ['replacers'] = {
        --         ['key'] = value,
        --         ...
        --     },

        --     ['monitors'] = {
        --         {
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number
        --         },
        --         ...
        --     },

        --     ['screens'] = {
        --         {
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,

        --             ['advance'] = {
        --                 ['durationMs'] = number,
        --                 ['position'] = vector3(number, number, numbe)]
        --             }
        --         },
        --         ...
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE,
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
    
        --             ['fx'] = {
        --                 ['library'] = string,
        --                 ['effect'] = string,
        --             },

        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
    
        --             ['fx'] = {
        --                 ['library'] = string,
        --                 ['effect'] = string,
        --             },

        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['soundOffset'] = vector3(number, number, number),
        --             ['directionOffset'] = vector3(number, number, number),
        --             ['maxDistance'] = number,
        --             ['refDistance'] = number,
        --             ['rolloffFactor'] = number,
        --             ['coneInnerAngle'] = number,
        --             ['coneOuterAngle'] = number,
        --             ['coneOuterGain'] = number,
        --             ['fadeDurationMs'] = number,
        --             ['volumeMultiplier'] = number,
        --             ['lowPassGainReductionPercent'] = number
        --         },
        --         ...
        --     ]
        -- }
        ['vitrine'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = nil,
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 1,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
            },

            ['area'] = {
                ['range'] = 120.0,
                ['center'] = vector3(-772.18,-784.85,12.69),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['big_screens'] = 'script_rt_big_disp',
            },

            ['monitors'] = nil,

            ['screens'] = {
                {
                    ['hash'] = 'prop_huge_display_01',
                    ['position'] = vector3(-772.18,-784.85,12.69),
                    ['rotation'] = nil,
                    ['heading'] = 360.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 10000,
                        ['position'] = vector3(-772.18,-784.85,12.69)
                    },
                },
            },

            ['smokers'] = {
                {--1
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(-766.69,-792.83,11.75),
                    ['rotation'] = vector3(0, 0.0, 300.00),
                    ['color'] = {242, 223, 7}
                },
                {--2
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1259.71936, -222.816147, 106.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
                {--3
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1275.78333, -235.07222, 106.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
                {--4
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
        
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },
        
                    ['position'] = vector3(1274.63354, -221.485657, 105.443695),
                    ['rotation'] = vector3(0, 0.0, 95.00),
                    ['color'] = {242, 7, 7}
                },
            },
            ['spotlights'] = nil,
            ['sparklers'] = nil,
            ['speakers'] = {
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-765.66,-793.26,12.67),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-777.89,-792.44,12.05),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-774.4,-812.91,12.05),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
                {
                    ['hash'] = 'xs_propintarena_speakers_01a',
                    ['visible'] = false,
                    ['position'] = vector3(-768.18,-812.82,12.05),
                    ['rotation'] = nil,
                    ['heading'] = 337.33,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
            },
        },
    }
}

