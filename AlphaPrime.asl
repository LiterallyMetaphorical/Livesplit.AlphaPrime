state("AlphaPrime")
{
    int loading : 0x36B8D0;
    string150 mission : 0x0030C52C, 0x1DC, 0x648, 0x28, 0x0;
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
    return old.mission != current.mission && current.mission.Contains("l00");
}

update
{ 
    //print(current.loading.ToString());
    //print(current.mission);
	vars.loading = current.loading != 256;
}

isLoading
{
    return vars.loading;
}

split 
{ 	
    return current.mission != old.mission;
}	

exit
{
    timer.IsGameTimePaused = true;
}
