stock ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
    new Float:oldposx, Float:oldposy, Float:oldposz;
    GetPlayerPos(playerid, oldposx, oldposy, oldposz);
    foreach (new i : Player)
    {
        //if(!BigEar[i])
        //{
            if(IsPlayerInRangeOfPoint(i, radi/16, oldposx, oldposy, oldposz)) SendClientMessage(i, col1, string);
            else if(IsPlayerInRangeOfPoint(i, radi/8, oldposx, oldposy, oldposz)) SendClientMessage(i, col2, string);
            else if(IsPlayerInRangeOfPoint(i, radi/4, oldposx, oldposy, oldposz)) SendClientMessage(i, col3, string);           
            else if(IsPlayerInRangeOfPoint(i, radi/2, oldposx, oldposy, oldposz)) SendClientMessage(i, col4, string);   
            else if(IsPlayerInRangeOfPoint(i, radi, oldposx, oldposy, oldposz)) SendClientMessage(i, col5, string);
        //}
        //else SendClientMessage(i, col1, string);
    }
    return 1;
}