state("AlphaPrime")
{
    int loading : 0x36B8D0;
    string150 mission : 0x0030C23C, 0x18, 0x5A8, 0x28, 0x0;
}

init
{
	vars.loading = false;
}   

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Alpha Prime",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

onStart
{
    // This is part of a "cycle fix", makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

start
{
    return old.mission != current.mission && current.mission.Contains("l0i");
}

update
{ 
    //print(current.loading.ToString());
    print(current.mission);
	vars.loading = current.loading != 256;
}

isLoading
{
    return vars.loading;
}

split 
{ 	return   
		(current.mission.Contains("l01")) && (current.mission != old.mission) || 
        (current.mission.Contains("l02")) && (current.mission != old.mission) || 
        (current.mission.Contains("l03")) && (current.mission != old.mission) ||
        (current.mission.Contains("l04")) && (current.mission != old.mission) ||
        (current.mission.Contains("l05")) && (current.mission != old.mission) ||
        (current.mission.Contains("l06")) && (current.mission != old.mission) ||
        (current.mission.Contains("l07")) && (current.mission != old.mission) ||
        (current.mission.Contains("l08")) && (current.mission != old.mission) ||
        (current.mission.Contains("l09")) && (current.mission != old.mission) ||
		(current.mission.Contains("l10")) && (current.mission != old.mission);
	}		


exit
{
    timer.IsGameTimePaused = true;
}
