// default includes for samp
#include <a_samp>
#include <core>
#include <float>
#include <Pawn.CMD> // Need PawnCMD plugin.
new recording[MAX_PLAYERS];
public OnPlayerConnect(playerid)
{
    recording[playerid] = 0;
}
CMD:record(playerid, params[])
{
   if(!strlen(params[0]) && recording[playerid] == 0) {
		SendClientMessage(playerid,0xFF0000FF,"Usage: /vrecord {name}");
		return 1;
	}
  
  // Start DRIVER record type, if player in vehicle and not recording at this moment.
	if(IsPlayerInAnyVehicle(playerid) && recording[playerid] == 0) {
	    recording[playerid] = 1;
	    StartRecordingPlayerData(playerid,PLAYER_RECORDING_TYPE_DRIVER,params[0]);
		return SendClientMessage(playerid,0xFF0000FF,"Recording: started.");
	}
  
  // Start ONFOOT record type, if player not in vehicle and not recording at this moment.
	if(!IsPlayerInAnyVehicle(playerid) && recording[playerid] == 0) {
		recording[playerid] = 1;
	    StartRecordingPlayerData(playerid,PLAYER_RECORDING_TYPE_ONFOOT,params[0]);
		return SendClientMessage(playerid,0xFF0000FF,"Recording: started.");
	}
  // Stop record if conditions didn't work.
	StopRecordingPlayerData(playerid);
	SendClientMessage(playerid,0xFF0000FF,"Recording: stopped.");
	recording[playerid] = 0;
	return 0;
}

