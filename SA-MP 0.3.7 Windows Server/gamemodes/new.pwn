main(){}

// ============ Includes ============

#include <a_samp>
#include <a_mysql>
#include <sscanf>
#include <streamer>
#include <Pawn.CMD>
#include <streamer>
#include <foreach>

// ==================================

// ============ server.cfg ============

#define ServerName 					"Drift"
#define ProjectName 				"Race"
#define ModeName 					"Drift"
#define Language 					"Russian"
#define WebURL 						"www.drift.ru"

#define MAX_PLAYER_PASSWORD			(24)
#define MIN_PLAYER_PASSWORD			(4)

#if !defined GetPlayerData
    #define GetPlayerData(%0,%1) PlayerInfo[%0][%1]
#endif
// ====================================

// ============ MYSQL CONNECT ============

#define MYSQL_USER ""
#define MYSQL_DB   ""
#define MYSQL_HOST ""
#define MYSQL_PASS ""

// =======================================
public OnGameModeInit()
{
	SendRconCommand("hostname "ProjectName" | "ServerName" | Открытие");
	SetGameModeText(""ModeName"");
	SendRconCommand("weburl "WebURL"");
	SetMySQLConnection();
	return 1;
}

// ============ Enums ============

enum E_PLAYER_INFO
{
	pID,
	pName[MAX_PLAYER_NAME],
	pPassword[MAX_PLAYER_PASSWORD],
	pLevel,
	pMoney,
	Float:pHealth,
	pSkin,
	pDriftSkill,
	pKills,
	pDeath
};
new PlayerInfo[MAX_PLAYERS][E_PLAYER_INFO];

// now?
enum
{
	dRegister,
	dAuth,
	dMenu
};
//================================
// ============ New's ============

new Float:SpawnInfo[][4] =
{
/*	X			Y			Z		Angle 			*/

	{2000.1141, 1525.5706, 14.6172, 342.8388},
	{2089.0220, 1450.4452, 10.8203, 142.9970}
};
//Компиляцию запусти
new vehicletimer;
new MySQL:dbHandle;

// ===============================
public OnGameModeExit()
{
	SendRconCommand("exit");
	return 1;
}

public OnPlayerConnect(playerid)
{
	for(new i; i < sizeof(SpawnInfo); i++)
	{
		SetPlayerPos(playerid, SpawnInfo[i][0], SpawnInfo[i][1], SpawnInfo[i][2]);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	new string[44 + (MAX_PLAYER_NAME + (-2))];
	format(string, sizeof string, "SELECT * FROM `accounts` WHERE `name` = '%s'", PlayerInfo[playerid][pName]);
	
	new Cache:h = mysql_query(dbHandle, string);
	new rows = cache_num_rows();

	if(rows)
	{
		static const fmt_str[] = "{FFFFFF}Добро пожаловать на {FF0000}"ProjectName" | "ServerName"\n\
			{FFFFFF}Статус аккаунта: {FF0000}незарегистрирован\n\
			{FFFFFF}Имя: {FF0000}%s\n\
			{FFFFFF}Введите ваш будующий пароль в поле ниже:";
		new str[sizeof fmt_str + (-2) + (MAX_PLAYER_NAME + 1) + 2];
		format(str, sizeof str, fmt_str, PlayerInfo[playerid][pName]);
		
		ShowPlayerDialog(playerid, dRegister, DIALOG_STYLE_INPUT, "{FFFFFF}Регистрация {00ff00}• Ввод пароля", str, "Далее", "Выход");
	}
	cache_delete(h);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	vehicletimer = GetPlayerVehicleID(playerid);
	DestroyVehicle(vehicletimer); // Запусти компиляцию!!!!
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case dRegister:
		{
			if(!response) 
				return Kick(playerid);
			if(!strlen(inputtext) || strlen(inputtext) < MIN_PLAYER_PASSWORD || strlen(inputtext) > MAX_PLAYER_PASSWORD)
				return SendErrorMessage(playerid, "[ Ошибка ] {FFFFFF}Длина пароля должна быть не менее 4-х символов, и не более 24-х символов!");
			
			
		} 
		// последний раз
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		static const fmt_str[] = "{00ff00}[Успешно]{FFFFFF} Вы были телепортированы на координаты %f %f %f";
		new str[73 + (-6) + 27];
		format(str, sizeof str, fmt_str, fX, fY, fZ);
		SendClientMessage(playerid, -1, str);
		return SetPlayerPos(playerid, fX, fY, fZ);	
	}

	return SendClientMessage(playerid, -1, "{FF0000}[Ошибка]{FFFFFF} Вы не можете телепортироваться в машине.");
}
CMD:addvehicle(playerid, params[])
{
	new vehicleid, color1, color2;
	if(sscanf(params, "ddd", vehicleid, color1, color2)) return SendClientMessage(playerid, -1, "{FF0000}[Ошибка]{FFFFFF} Используйте /addvehicle [ID] [COLOR1] [COLOR2]");
	if(color2 < 0 || color2 > 255 || color1 < 0 || color1 > 255) return SendClientMessage(playerid, -1, "{FF0000}[Ошибка]{FFFFFF} Цветное число не может быть ниже 0 или выше 255!");
	
	new Float:x, Float:y, Float:z;
	new Float:angle;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	vehicletimer = CreateVehicle(vehicleid, x, y, z, angle, color1, color2, -1);
	
	SetVehicleNumberPlate(vehicleid, "BIM BIM");
	RemovePlayerFromVehicle(playerid);
	PutPlayerInVehicle(playerid, vehicleid, 0);
	return SendClientMessage(playerid, -1, "{00ff00}[Успешно]{FFFFFF} Вы успешно заспавнили автомобиль.");

}

CMD:id(playerid, params[])
{
	extract params -> new targetid; else return SendClientMessage(playerid, 0xFF0000FF, "{828282} * Используйте: /id [Ник игрока]"); // проверям на то или игрок ввел все аргументы. если нет вводим ему сообщение
	SendClientMessage(playerid, -1, "{70b0ff}Игроки в сети:");
	
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0x828282FF, "Совпадений не найдено");
	
	static const fmt_string[] = "{FFFFFF}%s[%d] %d уровень";
	new string[sizeof fmt_string + (-6) + (MAX_PLAYER_NAME + 1) + 7];

	format(string, sizeof(string), fmt_string, GetPlayerData(targetid, pName), targetid, GetPlayerData(targetid, pLevel)); 
	return SendClientMessage(playerid, -1, string); 
}
stock SetMySQLConnection()
{
	dbHandle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	
	if(mysql_errno(dbHandle) != 0) {
		print("[ MYSQL ] Подключение...\n\
				[ MYSQL ] Нет подключения!\n\
				[ MYSQL ] Выключение..."
			);
		return SendRconCommand("exit");
	}

	print("[ MYSQL ] Подключение...\n[ MYSQL ] База данных подключена.\n[ MYSQL ] Created by Dorime");
	return SendRconCommand("hostname "ProjectName" | "ServerName"");
} 

stock SendErrorMessage(playerid, const message[]) {
	return SendClientMessage(playerid, 0xFF0000FF, message);
}
stock CreateNewAccount(playerid) {
	static const fmt_query[] = "INSERT INTO `accounts` ('pName', 'pPassword', 'pSkin') VALUES('%s', '%s', '%i')";
	new query[sizeof fmt_query + (-6) + (MAX_PLAYER_NAME + 1) + MAX_PLAYER_PASSWORD + 5];

	mysql_format(dbHandle, query, sizeof query, fmt_query, GetPlayerData(playerid, pName), GetPlayerData(playerid, pPassword), GetPlayerData(playerid, pSkin));
	return mysql_pquery(dbHandle, query, "OnCreatedNewAccount", "i", playerid);
}

forward OnCreatedNewAccount(playerid);
public OnCreatedNewAccount(playerid) {
	new rows;
	cache_get_row_count(rows);

	if(!rows) {
		printf("Произошла ошибка при создании записи аккаунта: %s[%i]. Код ошибки: %i", GetPlayerData(playerid, pName), playerid, mysql_errno());
		return Kick(playerid);
	}

	TogglePlayerSpectating(playerid, false);
	return SpawnPlayer(playerid);
}