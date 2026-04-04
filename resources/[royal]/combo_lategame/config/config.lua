local WEAPON_MODES = {
    Pistols = { 'WEAPON_PISTOL_MK2','WEAPON_APPISTOL' },
    Rifles = { 'WEAPON_SPECIALCARBINE_MK2','WEAPON_SPECIALCARBINE' },
    Submachine = { 'WEAPON_SMG_MK2','WEAPON_MACHINEPISTOL',"WEAPON_ASSAULTSMG" },
}

globalConfig = {
    DisableDimensionsVerify = true,
    MaximumRoomMembers = 15,

    SpawnTimes = {
        FirstRound = 30,
        OthersRounds = 5,
    },

    Maps = {
        ['PREDIO V2'] = {
            Name = 'PREDIO V2',
            Banner = '../lategame/semnome.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-8637.29, 3018.2, 472.18),
            },
            SideTwo = {
                [1] = vector3(-8702.42, 3021.8, 472.18),
            },
            Safezone = {
                Center = vector3(-8669.47,3018.14,472.18),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['CS Piscina'] = {
            Name = 'CS Piscina',
            Banner = '../lategame/cspiscina.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(237.06,-1933.73,814.68),
            },
            SideTwo = {
                [1] = vector3(212.11,-1934.59,814.68),
            },
            Safezone = {
                Center = vector3(224.19, -1932.22, 812.52),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Banco Paleto'] = {
            Name = 'Banco Paleto',
            Banner = '../lategame/bancopaleto.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-54.18,6530.75,31.5),
            },
            SideTwo = {
                [1] = vector3(-161.69,6426.91,31.9),
            },
            Safezone = {
                Center = vector3(-90.09, 6447.7, 31.41),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Observatory'] = {
            Name = 'FF Observatory',
            Banner = '../lategame/observatory.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-255.81, -3665.57, 273.37),
            },
            SideTwo = {
                [1] = vector3(-285.77, -3785.41, 270.21),
            },
            Safezone = {
                Center = vector3(-286.76, -3728.76, 271.32),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['capetown'] = {
            Name = 'FF Cape Town',
            Banner = '../lategame/capetown.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-3526.86, 4630.14, 324.72),
            },
            SideTwo = {
                [1] = vector3(-3679.57, 4600.61, 324.81),
            },
            Safezone = {
                Center = vector3(-3606.74, 4616.37, 324.79),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Comedy'] = {
            Name = 'Comedy',
            Banner = '../lategame/comedy.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-415.61,291.26,83.23),
            },
            SideTwo = {
                [1] = vector3(-517.82,288.49,83.2),
            },
            Safezone = {
                Center = vector3(-461.9,282.08,83.25),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Mirage Exclusive'] = {
            Name = 'Mirage',
            Banner = '../lategame/mirage.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-2719.95,-2708.05,453.97),
            },
            SideTwo = {
                [1] = vector3(-2613.64,-2718.96,457.89),
            },
            Safezone = {
                Center = vector3(-2661.03,-2704.47,455.02),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Dust 1.6'] = {
            Name = 'Dust 1.6',
            Banner = '../lategame/dust.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-5886.45,1857.57,667.73),
            },
            SideTwo = {
                [1] = vector3(-5839.81,1787.44,674.13),
            },
            Safezone = {
                Center = vector3(-5912.9, 1818.11, 671.33),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Ilha'] = {
            Name = 'Ilha',
            Banner = '../lategame/ilha.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(5284.89, -5468.0, 58.65),
            },
            SideTwo = {
                [1] = vector3(5133.51, -4933.2, 15.26),
            },
            Safezone = {
                Center = vector3(5155.59, -5145.45, 2.34),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 500
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['ClockTower'] = {
            Name = 'FF ClockTower',
            Banner = '../lategame/clocktower.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-3187.83,-2572.74,12.24),
            },
            SideTwo = {
                [1] = vector3(-3331.67,-2486.48,10.75),
            },
            Safezone = {
                Center = vector3(-3294.78,-2533.22,18.23),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 200,
                Initial = {
                    Radius = 200
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Prefeitura'] = {
            Name = 'Prefeitura',
            Banner = '../lategame/prefeitura.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(2526.26, -289.03, 92.99),
            },
            SideTwo = {
                [1] = vector3(2486.87, -454.2, 92.98),
            },
            Safezone = {
                Center = vector3(2493.66, -377.85, 94.12),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
        ['Haven'] = {
            Name = 'Haven',
            Banner = '../lategame/haven.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(3987.21, 7549.14, 1476.68),
            },
            SideTwo = {
                [1] = vector3(4025.66, 7469.77, 1476.7),
            },
            Safezone = {
                Center = vector3(3997.04, 7518.07, 1479.79),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },

        ['Predinho'] = {
            Name = 'Predinho',
            Banner = '../lategame/predinho.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(120.71, -878.59, 134.78),
            },
            SideTwo = {
                [1] = vector3(83.2, -864.77, 134.78),
            },
            Safezone = {
                Center = vector3(98.27, -882.91, 134.78),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },

        ['Fazenda'] = {
            Name = 'Fazenda',
            Banner = '../lategame/fazenda.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(-1313.27, -5116.43, 212.22),
            },
            SideTwo = {
                [1] = vector3(-1313.4, -5063.59, 212.22),
            },
            Safezone = {
                Center = vector3(-1291.38, -5086.17, 212.22),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },


        ['Containers'] = {
            Name = 'ARENA DE CONTAINERS',
            Banner = '../lategame/containers.png',
            SpawnDistance = 10,
            SideOne = {
                [1] = vector3(934.77, -3408.8, 7.09),
            },
            SideTwo = {
                [1] = vector3(1084.04, -3401.81, 7.09),
            },
            Safezone = {
                Center = vector3(1013.6, -3397.72, 7.09),
                Variation = 20,
                DamagePerSecond = 25,
                TimeToClose = 150,
                Initial = {
                    Radius = 150
                },
                Finale = {
                    Radius = 5
                }
            },
        },
    },

    Modes = {
        ['Pistols'] = { Name = 'Pistola', Banner = '../lategame/pistol.png' },
        ['Rifles'] = { Name = 'Rifle', Banner = '../lategame/rifle.png' },
        ['Submachine'] = { Name = 'Subs', Banner = '../lategame/smg.png' },
        ['MixedGuns'] = { Name = 'Misto', Banner = '../lategame/mixed.png' },
    },

    Rounds = {
        Pistols = {
            [1] = WEAPON_MODES.Pistols,
            [2] = WEAPON_MODES.Pistols,
            [3] = WEAPON_MODES.Pistols,
            [4] = WEAPON_MODES.Pistols,
            [5] = WEAPON_MODES.Pistols,
            [6] = WEAPON_MODES.Pistols,
            [7] = WEAPON_MODES.Pistols,
        },
        Rifles = {
            [1] = WEAPON_MODES.Rifles,
            [2] = WEAPON_MODES.Rifles,
            [3] = WEAPON_MODES.Rifles,
            [4] = WEAPON_MODES.Rifles,
            [5] = WEAPON_MODES.Rifles,
            [6] = WEAPON_MODES.Rifles,
            [7] = WEAPON_MODES.Rifles,
        },
        Submachine = {
            [1] = WEAPON_MODES.Submachine,
            [2] = WEAPON_MODES.Submachine,
            [3] = WEAPON_MODES.Submachine,
            [4] = WEAPON_MODES.Submachine,
            [5] = WEAPON_MODES.Submachine,
            [6] = WEAPON_MODES.Submachine,
            [7] = WEAPON_MODES.Submachine,
        },
        MixedGuns = {
            [1] = WEAPON_MODES.Pistols,
            [2] = WEAPON_MODES.Pistols,
            [3] = WEAPON_MODES.Submachine,
            [4] = WEAPON_MODES.Submachine,
            [5] = WEAPON_MODES.Rifles,
            [6] = WEAPON_MODES.Rifles,
            [7] = WEAPON_MODES.Rifles,
        },
    },

    Language = {
        WinningTeam = 'Round finalizado! O time ganhador foi %s',
        RequestSent = 'Solicitação enviada.',
        MatchCanceled = 'Partida cancelada pois o player: %s está proibido de entrar no Late Game.',
        StartVotation = 'Iniciando votações. Digite /lategame para acompanhar.',
        VotingCanceled = 'Votação cancelada pois algum membro desconectou.',
        PendingRequests = 'Você tem solicitações pendentes. Aguarde um pouco para enviar novamente.',
        ScriptRestarted = 'Seu jogo foi cancelado devido a reinicialização do script.',
        CannotOpenPanel = 'Você não pode abrir o painel do LateGame no momento.',
        AcceptChallenge = '%s com %d/%d membros está te desafiando, deseja aceitar?',
        ThisRoomInVoting = 'Esta sala já está em votação.',
        SpectatingPlayer = 'Você está espectando o player: ',
        ExitSpectatorMode = 'Deseja sair do modo spectador?',
        CannotUseThisName = 'Você não pode usar esse nome.',
        NameAlreadyExists = 'Já existe uma sala com esse nome.',
        WeaponVoteCompleted = 'Votação de armas finalizada. Iniciando votação de mapas. Digite /lategame para acompanhar.',
        MaximumLimitOfPlayers = 'Limite maximo de players atingidos.',
        YouWereKickedOfTheRoom = 'Você foi expulso da sala.',
        CannotChallengeYourRoom = 'Você não pode desafiar sua propria sala.',
        Teams = 'Times',
        Monitor = 'Monitorar',
        Spectate = 'Espectar',
        Challenges = 'Desafiar',
    }
}

function globalConfig.notify(...)
    local args = {...}

    local notifyTypes = {
        [1] = 'negado',
        [2] = 'sucesso',
        [3] = 'importante',
    }

    if IsDuplicityVersion() then
        local source = args[1]

        TriggerClientEvent('Notify', source, notifyTypes[args[2]],"PvP",args[3], args[4])
    else
        TriggerEvent('Notify', notifyTypes[args[1]],"PvP",args[2], args[3])
    end
end

return globalConfig