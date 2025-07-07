// Credit to Sara Spalding's video: https://www.youtube.com/watch?v=Sp623fof_Ck&list=PLPRT_JORnIurSiSB5r7UQAdzoEv-HF24L
// Party data
global.party =
[
	{
		name: "Vaultie",
		hp: 100,
		hp_max: 100,
		ap: 10,
		ap_max: 10,
		bet: 100,
		bet_max: 100,
		sprites: { idle: spr_placeholder, attack: spr_placeholder, dodge: spr_placeholder, down: spr_placeholder},
		actions: []
	}
	,
	{
		name: "Lobotomite",
		hp: 100,
		hp_max: 100,
		ap: 10,
		ap_max: 10,
		bet: 100,
		bet_max: 100,
		sprites: { idle: spr_placeholder, attack: spr_placeholder, dodge: spr_placeholder, down: spr_placeholder},
		actions: []
	}
];

// Enemy data
global.enemies =
{
	orderly_mk1:
	{
		name: "Mister Orderly MK1",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder},
		actions: [],
		xp: 100,
		AIscript: function()
		{
			// Enemy turn AI goes here	
		}
	}
	,
	cyberdog_police:
	{
		name: "Police Cyberdog",
		hp: 30,
		hp_max: 30,
		ap: 10,
		ap_max: 10,
		sprites: { idle: spr_placeholder, attack: spr_placeholder},
		actions: [],
		xp: 100,
		AIscript: function()
		{
			// Enemy turn AI goes here	
		}
	}
}