#displays vm's on this server. may not want this in end state. will have to look further into dashboard options
get-vm

#takes vm stats a second apart for 5 seconds. will implement this later as a single call and schedule through windows at a regular interval
$i=0
while($i -le 5){
#array for intra-server vm comparisons 
    $myarray += get-vm | select name, cpuusage, memoryassigned 
#master file with all vms for one server
    get-vm | select name, cpuusage, memoryassigned | export-csv -append $("C:\Users\212416516\Documents\powershell\vms\vm_usage.txt") -force
    start-sleep 1
    $i++
}

#array of vm names to allow us to navigate $myarray object
$vms = @($myarray | sort-object name -unique | select name) 

#loop over the length of our unique name array
for ($j=0; $j -lt $vms.length; $j++){
#store vm data in separate text files by vm name
    $myarray | where-object {$_.name -like $vms.name[$j]} | export-csv -append $("C:\Users\212416516\Documents\powershell\vms\"+$vms.name[$j]+".txt") -force
#display measure object stats for each vm    
    $myarray | where-object {$_.name -like $vms.name[$j]} | measure-object cpuusage -ave -sum -max -min 
}




